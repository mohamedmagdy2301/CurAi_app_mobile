import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ApiConsumer {
  Future<Either<Failure, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, dynamic>> post(
    String url, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, dynamic>> put(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, dynamic>> patch(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
  });
}
