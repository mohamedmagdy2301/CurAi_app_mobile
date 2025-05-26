// ignore_for_file: strict_raw_type, document_ignores, lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, avoid_catches_without_on_clauses, inference_failure_on_function_return_type

import 'dart:io';

import 'package:curai_app_mobile/core/api/status_code.dart';
import 'package:curai_app_mobile/core/app/env_variables.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioConfigurator {
  static const Duration _defaultTimeouts = Duration(seconds: 30);

  static void configure(Dio dio) {
    _setUpCertificateBypass(dio);
    _addBaseInterceptors(dio);
    // if (kDebugMode) dio.interceptors.add(di.sl<LogInterceptor>());
  }

  static void _setUpCertificateBypass(Dio dio) {
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient()
        ..badCertificateCallback = (_, __, ___) => true;
      return client;
    };
  }

  static void _addBaseInterceptors(Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _setDefaultHeaders(options);
          _setTimeouts(options);
          return handler.next(options);
        },
      ),
    );
  }

  static void _setDefaultHeaders(RequestOptions options) {
    options.headers['Accept'] = 'application/json';
    options.headers['X-Requested-With'] = 'XMLHttpRequest';
    if (options.data is! FormData) {
      options.headers['Content-Type'] = 'application/json';
    }
    if (getAccessToken().isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${getAccessToken()}';
    }
  }

  static void _setTimeouts(RequestOptions options) {
    options
      ..baseUrl = AppEnvironment.baseApiUrl
      ..sendTimeout = _defaultTimeouts
      ..connectTimeout = _defaultTimeouts
      ..receiveTimeout = _defaultTimeouts
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus =
          (status) => status != null && status < StatusCode.internalServerError;
  }
}
