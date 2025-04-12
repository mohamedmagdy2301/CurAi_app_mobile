// ignore_for_file: no_default_cases, inference_failure_on_function_invocation, document_ignores, avoid_catches_without_on_clauses, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:curai_app_mobile/core/api/api_consumer.dart';
import 'package:curai_app_mobile/core/api/app_interceptors.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:curai_app_mobile/core/api/status_code.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/helper/logger_helper.dart';
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

  void _configureDio() {
    (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final httpClient = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };

    client.options
      ..baseUrl = EndPoints.baseUrl
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
      () => client.put(
        url,
        queryParameters: queryParameters,
        data: body,
      ),
    );
  }

  @override
  Future<Either<Failure, dynamic>> patch(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeApiCall(
      () => client.patch(
        url,
        queryParameters: queryParameters,
        data: body,
      ),
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
    if (response.statusCode == StatusCode.ok ||
        response.statusCode == StatusCode.okCreated) {
      final data = jsonDecode(response.data.toString());
      return right(data);
    }

    if (response.statusCode == StatusCode.unauthorized ||
        response.statusCode == StatusCode.forbidden ||
        (response.data != null && response.data!['detail'] == 'Expired JWT.')) {
      final refreshToken =
          CacheDataHelper.getData(key: SharedPrefKey.keyRefreshToken);

      if (refreshToken != null && refreshToken != '' && !_isRefreshing) {
        _isRefreshing = true;
        final refreshed = await _refreshToken(refreshToken as String);
        _isRefreshing = false;

        if (refreshed && retryRequest != null) {
          final retriedResponse = await retryRequest();
          return _handleResponseAsJson(retriedResponse, null);
        } else {
          await _handleLogout();
        }
      } else {
        await _handleLogout();
      }
    }

    return left(
      ServerFailure.fromBadResponse(
        response.statusCode!,
        jsonDecode(response.data.toString()),
      ),
    );
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
          // di.sl<AuthCubit>().logout();
          CacheDataHelper.removeData(key: SharedPrefKey.keyAccessToken);
          CacheDataHelper.removeData(key: SharedPrefKey.keyRefreshToken);
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
        final newAccessToken = jsonDecode(response.data as String)['access'];
        await CacheDataHelper.setData(
          key: SharedPrefKey.keyAccessToken,
          value: newAccessToken,
        );
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        LoggerHelper.error('Error while refreshing token: $e');
      }
      await _handleLogout();
    }
    return false;
  }
}
