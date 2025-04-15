// ignore_for_file: strict_raw_type, document_ignores, lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, avoid_catches_without_on_clauses, inference_failure_on_function_return_type

import 'dart:convert';
import 'dart:io';

import 'package:curai_app_mobile/core/api/api_consumer.dart';
import 'package:curai_app_mobile/core/api/app_interceptors.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:curai_app_mobile/core/api/status_code.dart';
import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DioConsumer implements ApiConsumer {
  DioConsumer({required this.client}) {
    _configureDio();
  }

  final Dio client;
  static bool _isRefreshing = false;
  static final List<Function()> _refreshQueue = [];

  void _configureDio() {
    (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final httpClient = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };

    client.options
      ..baseUrl = EnvVariables.baseApiUrl
      ..connectTimeout = const Duration(seconds: 20)
      ..receiveTimeout = const Duration(seconds: 20)
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus =
          (status) => status != null && status < StatusCode.internalServerError;

    client.interceptors.add(di.sl<AppInterceptors>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  @override
  Future<Either<Failure, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeApiCall(
      () => client.get(url, queryParameters: queryParameters),
    );
  }

  @override
  Future<Either<Failure, dynamic>> post(
    String url, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeApiCall(
      () => client.post(
        url,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body ?? {}) : body,
      ),
    );
  }

  @override
  Future<Either<Failure, dynamic>> put(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeApiCall(
      () => client.put(url, queryParameters: queryParameters, data: body),
    );
  }

  @override
  Future<Either<Failure, dynamic>> patch(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeApiCall(
      () => client.patch(url, queryParameters: queryParameters, data: body),
    );
  }

  Future<Either<Failure, dynamic>> _safeApiCall(
    Future<Response<dynamic>> Function() apiCall,
  ) async {
    try {
      final response = await apiCall();
      return _handleResponseAsJson(response, apiCall);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } on SocketException catch (e) {
      return left(ServerFailure(e.toString()));
    } on FormatException catch (e) {
      return left(ServerFailure(e.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, dynamic>> _handleResponseAsJson(
    Response<dynamic> response,
    Future<Response<dynamic>> Function()? retryRequest,
  ) async {
    final decoded = jsonDecode(response.data.toString());
    final isJwtExpired = decoded is Map &&
        (decoded['detail']?.toString().toLowerCase().contains('expired') ??
            false);
    if (response.statusCode == StatusCode.ok ||
        response.statusCode == StatusCode.okCreated) {
      return right(decoded);
    }
    if (response.statusCode == StatusCode.unauthorized ||
        response.statusCode == StatusCode.forbidden ||
        isJwtExpired) {
      final refreshToken = await CacheDataHelper.getSecureData(
        key: SharedPrefKey.keyRefreshToken,
      );
      if (refreshToken != '' && !_isRefreshing) {
        _isRefreshing = true;
        final refreshed = await _refreshToken(refreshToken);
        _isRefreshing = false;
        if (refreshed && retryRequest != null) {
          final retriedResponse = await retryRequest();
          return _handleResponseAsJson(retriedResponse, null);
        } else {
          await _handleLogout();
        }
      } else {
        _addToQueue(retryRequest);
      }
    }

    return left(ServerFailure.fromBadResponse(response.statusCode!, decoded));
  }

  void _addToQueue(Future<Response<dynamic>> Function()? retryRequest) {
    if (retryRequest != null) {
      _refreshQueue.add(() async {
        final retriedResponse = await retryRequest();
        final decoded = jsonDecode(retriedResponse.data.toString());
        return decoded;
      });
    }
  }

  Future<void> _processQueue() async {
    while (_refreshQueue.isNotEmpty) {
      final request = _refreshQueue.removeAt(0);
      await request();
    }
  }

  Future<void> _handleLogout() async {
    final context = di.sl<GlobalKey<NavigatorState>>().currentContext;

    if (context != null) {
      await AdaptiveDialogs.showLogoutAlertDialog(
        context: context,
        title: context.isStateArabic ? 'انتهت الجلسة' : 'Session Expired',
        message: context.isStateArabic
            ? 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.'
            : 'Your session has expired. Please log in again.',
        onPressed: () {
          CacheDataHelper.removeSecureData(key: SharedPrefKey.keyAccessToken);
          CacheDataHelper.removeSecureData(key: SharedPrefKey.keyRefreshToken);
          CacheDataHelper.removeData(key: SharedPrefKey.keyUserId);
          CacheDataHelper.removeData(key: SharedPrefKey.keyUserName);
          CacheDataHelper.removeData(key: SharedPrefKey.keyRole);
          context
            ..pop()
            ..pushNamedAndRemoveUntil(Routes.loginScreen);
        },
      );
    }
  }

  Future<bool> _refreshToken(String refreshToken) async {
    try {
      final response = await client.post(
        EndPoints.refreshToken,
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.data.toString());
        if (decoded is Map && decoded.containsKey('access')) {
          final newAccessToken = decoded['access'];
          await CacheDataHelper.saveSecureData(
            key: SharedPrefKey.keyAccessToken,
            value: newAccessToken as String,
          );
          await _processQueue();
          return true;
        } else {}
      } else {}
    } catch (e) {}

    await _handleLogout();
    return false;
  }
}
