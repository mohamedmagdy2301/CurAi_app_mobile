// ignore_for_file: lines_longer_than_80_chars, document_ignores

import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:dartz/dartz.dart';

/// Abstract interface for making HTTP API requests.
/// Provides common methods used by the DioConsumer implementation.
abstract class ApiConsumer {
  /// Sends a GET request to the specified [url] with optional [queryParameters].
  ///
  /// Returns either a [Failure] on error or the response data on success.
  Future<Either<Failure, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  });

  /// Sends a POST request to the specified [url] with optional [body] and [queryParameters].
  ///
  /// If [formDataIsEnabled] is true, the body will be sent as multipart form data.
  ///
  /// Returns either a [Failure] on error or the response data on success.
  Future<Either<Failure, dynamic>> post(
    String url, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  });

  /// Sends a PUT request to the specified [url] with an optional [body] and [queryParameters].
  ///
  /// Returns either a [Failure] on error or the response data on success.
  Future<Either<Failure, dynamic>> put(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
  });

  /// Sends a PATCH request to the specified [url] with an optional [body] and [queryParameters].
  ///
  /// Returns either a [Failure] on error or the response data on success.
  Future<Either<Failure, dynamic>> patch(
    String url, {
    dynamic body,
    bool formDataIsEnabled,
    Map<String, dynamic>? queryParameters,
  });

  /// Sends a DELETE request to the specified [url] with optional [queryParameters].
  ///
  /// Returns either a [Failure] on error or the response data on success.
  Future<Either<Failure, dynamic>> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
  });
}
