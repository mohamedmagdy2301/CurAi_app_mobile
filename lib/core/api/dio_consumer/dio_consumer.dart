// ignore_for_file: strict_raw_type, document_ignores, lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, avoid_catches_without_on_clauses, inference_failure_on_function_return_type

import 'dart:async';
import 'dart:io';

import 'package:curai_app_mobile/core/api/api_consumer.dart';
import 'package:curai_app_mobile/core/api/dio_consumer/dio_configurator.dart';
import 'package:curai_app_mobile/core/api/dio_consumer/request_data_builder.dart';
import 'package:curai_app_mobile/core/api/dio_consumer/response_handler.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class DioConsumer implements ApiConsumer {
  DioConsumer({required this.client}) {
    DioConfigurator.configure(client);
  }

  final Dio client;

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
    dynamic body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeApiCall(() {
      final data = RequestDataBuilder.buildRequestData(
        body,
        formDataIsEnabled: formDataIsEnabled,
      );
      return client.post(url, queryParameters: queryParameters, data: data);
    });
  }

  @override
  Future<Either<Failure, dynamic>> put(
    String url, {
    dynamic body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeApiCall(() {
      final data = RequestDataBuilder.buildRequestData(
        body,
        formDataIsEnabled: formDataIsEnabled,
      );
      return client.put(url, queryParameters: queryParameters, data: data);
    });
  }

  @override
  Future<Either<Failure, dynamic>> patch(
    String url, {
    dynamic body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeApiCall(() {
      final data = RequestDataBuilder.buildRequestData(
        body,
        formDataIsEnabled: formDataIsEnabled,
      );
      return client.patch(url, queryParameters: queryParameters, data: data);
    });
  }

  @override
  Future<Either<Failure, dynamic>> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeApiCall(
      () => client.delete(url, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> _safeApiCall(
    Future<Response<dynamic>> Function() apiCall,
  ) async {
    try {
      final response = await apiCall();
      return ResponseHandler.handleResponse(response, apiCall);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } on SocketException catch (e) {
      return left(ServerFailure(e.toString()));
    } on FormatException catch (e) {
      return left(ServerFailure(e.toString()));
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
