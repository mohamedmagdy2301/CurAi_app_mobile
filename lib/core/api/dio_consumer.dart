// ignore_for_file: strict_raw_type, document_ignores, lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, avoid_catches_without_on_clauses, inference_failure_on_function_return_type

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:curai_app_mobile/core/api/api_consumer.dart';
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

/// A custom Dio-based API consumer that handles HTTP requests with support for:
/// - Centralized headers
/// - SSL bypass
/// - JWT token refresh logic
/// - Retry queue
/// - Unified error handling
class DioConsumer implements ApiConsumer {
  DioConsumer({required this.client}) {
    _configureDio(client);
  }

  final Dio client;

  /// Default timeout for all requests.
  static const _defaultTimeouts = Duration(seconds: 20);

  /// Whether the token is currently being refreshed.
  static bool _isRefreshing = false;

  /// Queue to hold retry requests while a token is refreshing.
  static final List<Function()> _refreshQueue = [];

  /// Configure Dio instance with base options and optional logging.
  void _configureDio(Dio dio) {
    // Accept self-signed certificates (for development purposes).
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final httpClient = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };

    dio.options
      ..headers['Accept'] = 'application/json'
      ..headers['Content-Type'] = 'application/json'
      ..headers['X-Requested-With'] = 'XMLHttpRequest'
      ..baseUrl = EnvVariables.baseApiUrl
      ..sendTimeout = _defaultTimeouts
      ..connectTimeout = _defaultTimeouts
      ..receiveTimeout = _defaultTimeouts
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus =
          (status) => status != null && status < StatusCode.internalServerError;

    // Attach token if available.
    final token =
        CacheDataHelper.getData(key: SharedPrefKey.keyAccessToken) ?? '';
    if ((token as String).isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    // Add logging interceptor in debug mode.
    if (kDebugMode) {
      dio.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  /// GET request
  @override
  Future<Either<Failure, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeApiCall(
      () => client.get(url, queryParameters: queryParameters),
    );
  }

  /// POST request with optional FormData support
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

  /// PUT request
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

  /// PATCH request
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

  /// Wraps the API call to handle Dio errors, timeouts, and formatting exceptions.
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

  /// Processes the API response, handles token refresh if needed, and retries if possible.
  Future<Either<Failure, dynamic>> _handleResponseAsJson(
    Response<dynamic> response,
    Future<Response<dynamic>> Function()? retryRequest,
  ) async {
    final data = response.data is String
        ? jsonDecode(response.data as String)
        : response.data;

    final isJwtExpired = data is Map &&
        (data['detail'].toString().toLowerCase().contains('expired') == true ||
            data['detail'].toString().toLowerCase().contains('jwt') == true);

    if (response.statusCode == StatusCode.ok ||
        response.statusCode == StatusCode.okCreated) {
      return right(data);
    }

    if (response.statusCode == StatusCode.unauthorized ||
        response.statusCode == StatusCode.forbidden ||
        isJwtExpired) {
      final refreshToken =
          CacheDataHelper.getData(key: SharedPrefKey.keyRefreshToken);

      // If refresh in progress, queue the request.
      if (_isRefreshing) {
        final completer = Completer<Either<Failure, dynamic>>();
        _refreshQueue.add(() async {
          try {
            final retried = await retryRequest!();
            final result = await _handleResponseAsJson(retried, null);
            completer.complete(result);
          } catch (e) {
            completer.complete(left(ServerFailure(e.toString())));
          }
        });
        return completer.future;
      }

      // Otherwise, refresh and retry.
      if (refreshToken != null && refreshToken != '') {
        _isRefreshing = true;
        final refreshed = await _refreshToken(refreshToken as String);
        _isRefreshing = false;
        if (refreshed && retryRequest != null) {
          final retriedResponse = await retryRequest();
          return _handleResponseAsJson(retriedResponse, null);
        } else {
          await _handleLogout();
        }
      }
    }

    return left(ServerFailure.fromBadResponse(response.statusCode!, data));
  }

  /// Executes all queued retry requests after token refresh is complete.
  Future<void> _processQueue() async {
    while (_refreshQueue.isNotEmpty) {
      final request = _refreshQueue.removeAt(0);
      await request();
    }
  }

  /// Handles user logout and shows session expired dialog.
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

  /// Refreshes the JWT token using the refresh token.
  /// Returns true if the access token was refreshed and stored successfully.
  Future<bool> _refreshToken(String refreshToken) async {
    try {
      final refreshDio = Dio();

      _configureDio(refreshDio);

      final response = await refreshDio.post(
        '${EnvVariables.baseApiUrl}${EndPoints.refreshToken}',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = response.data is String
            ? jsonDecode(response.data as String)
            : response.data;

        if (decoded is Map && decoded.containsKey('access')) {
          final newAccessToken = decoded['access'];
          await CacheDataHelper.setData(
            key: SharedPrefKey.keyAccessToken,
            value: newAccessToken,
          );

          client.options.headers['Authorization'] = 'Bearer $newAccessToken';
          await _processQueue();
          return true;
        } else {
          log('Failed to extract access token from response');
        }
      } else {
        log('Refresh token request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      log('Exception during token refresh: $e');
    }

    await _handleLogout();
    return false;
  }
}
