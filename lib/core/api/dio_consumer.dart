// ignore_for_file: no_default_cases,
// ignore_for_file: inference_failure_on_function_invocation, document_ignores

import 'dart:convert';
import 'dart:io';

import 'package:curai_app_mobile/core/api/api_consumer.dart';
import 'package:curai_app_mobile/core/api/app_interceptors.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/status_code.dart';
import 'package:curai_app_mobile/core/di/dependency_injection.dart' as di;
import 'package:curai_app_mobile/core/error/failure.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class DioConsumer implements ApiConsumer {
  DioConsumer({required this.client}) {
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

    client.interceptors.add(di.sl<AppIntercepters>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  final Dio client;

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body ?? {}) : body,
      );
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          await client.put(path, queryParameters: queryParameters, data: body);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    return jsonDecode(response.data.toString());
  }

  Exception _handleDioError(DioException error) {
    return FailureException(ServerFailure.fromDioException(error));
  }
}

class FailureException implements Exception {
  FailureException(this.failure);
  final Failure failure;

  @override
  String toString() => failure.message;
}
