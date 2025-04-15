// ignore_for_file: strict_raw_type, document_ignores, lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, avoid_catches_without_on_clauses

import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors({required this.client});

  final Dio client;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token =
        CacheDataHelper.getSecureData(key: SharedPrefKey.keyAccessToken);
    options
      ..headers['Content-Type'] = 'application/json'
      ..headers['Accept'] = 'application/json';
    if ((token as String).isNotEmpty) {
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
    // log('==========================================================');
    // if (err.response != null &&
    //     (err.response?.statusCode == 401 ||
    //         err.response?.statusCode == 403 ||
    //         err.response!.data['detail'] == 'Expired JWT.')) {
    //   final accessToken =
    //       CacheDataHelper.getData(key: SharedPrefKey.keyAccessToken) ?? '';
    //   final refreshToken =
    //       CacheDataHelper.getData(key: SharedPrefKey.keyRefreshToken) ?? '';

    //   if (accessToken != '' && refreshToken != '') {
    //     if (await _refreshToken(refreshToken as String)) {
    //       return handler.resolve(await retry(err.requestOptions));
    //     }
    //   }
    //   log('==========================================================');
    // }
    super.onError(err, handler);
  }

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final newAccessToken =
        await CacheDataHelper.getSecureData(key: SharedPrefKey.keyAccessToken);

    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $newAccessToken',
      },
    );
    return client.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
