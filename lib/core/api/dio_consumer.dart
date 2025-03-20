// ignore_for_file: no_default_cases, inference_failure_on_function_invocation, document_ignores, avoid_catches_without_on_clauses

import 'dart:io';

import 'package:curai_app_mobile/core/api/api_consumer.dart';
import 'package:curai_app_mobile/core/api/app_interceptors.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/status_code.dart';
import 'package:curai_app_mobile/core/di/dependency_injection.dart' as di;
import 'package:curai_app_mobile/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class DioConsumer implements ApiConsumer {
  DioConsumer({required this.client}) {
    _configureDio();
  }

  final Dio client;

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

    client.interceptors.add(di.sl<AppIntercepters>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return _handleResponseAsJson(
        await client.get(
          url,
          queryParameters: queryParameters,
        ),
      );
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } on SocketException catch (e) {
      return left(ServerFailure(e.toString()));
    } on FormatException catch (e) {
      return left(ServerFailure(e.toString()));
    } on SignalException catch (e) {
      return left(ServerFailure(e.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> post(
    String url, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return _handleResponseAsJson(
        await client.post(
          url,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body ?? {}) : body,
        ),
      );
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } on SocketException catch (e) {
      return left(ServerFailure(e.toString()));
    } on FormatException catch (e) {
      return left(ServerFailure(e.toString()));
    } on SignalException catch (e) {
      return left(ServerFailure(e.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> put(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return _handleResponseAsJson(
        await client.put(
          url,
          queryParameters: queryParameters,
          data: body,
        ),
      );
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } on SocketException catch (e) {
      return left(ServerFailure(e.toString()));
    } on FormatException catch (e) {
      return left(ServerFailure(e.toString()));
    } on SignalException catch (e) {
      return left(ServerFailure(e.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  Either<Failure, Map<String, dynamic>> _handleResponseAsJson(
    Response<Map<String, dynamic>> response,
  ) {
    if (response.statusCode == StatusCode.ok ||
        response.statusCode == StatusCode.okCreated) {
      return right(response.data!);
    } else {
      return left(
        ServerFailure.fromBadResponse(
          response.statusCode!,
          response.data,
        ),
      );
    }
  }
}
