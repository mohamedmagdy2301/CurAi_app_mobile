// ignore_for_file: strict_raw_type, document_ignores, lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, avoid_catches_without_on_clauses

import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/utils/helper/logger_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppIntercepters extends Interceptor {
  AppIntercepters({required this.client});

  final Dio client;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token =
        SharedPrefManager.getString(SharedPrefKey.keyAccessToken) ?? '';
    // final lang = SharedPrefManager.getString(SharedPrefKey.keyLocale) ?? 'en';
    options
      ..headers['Content-Type'] = 'application/json'
      ..headers['Accept'] = 'application/json';
    // ..headers['lang'] = lang;
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response != null && err.response?.statusCode == 401) {
      final accessToken =
          SharedPrefManager.getString(SharedPrefKey.keyAccessToken) ?? '';
      final refreshToken =
          SharedPrefManager.getString(SharedPrefKey.keyRefreshToken) ?? '';

      if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
        if (await _refreshToken(refreshToken)) {
          return handler.resolve(await retry(err.requestOptions));
        }
      }
    }
    super.onError(err, handler);
  }

  Future<bool> _refreshToken(String refreshToken) async {
    try {
      final response = await client.post(
        EndPoints.refreshToken,
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['access'];
        await SharedPrefManager.setData(
          key: SharedPrefKey.keyAccessToken,
          value: newAccessToken,
        );

        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        LoggerHelper.error('Error while refreshing token: $e');
      }
    }
    return false;
  }

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return client.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
