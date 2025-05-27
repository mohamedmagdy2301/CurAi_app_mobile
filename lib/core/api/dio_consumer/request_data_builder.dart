// ignore_for_file: strict_raw_type, document_ignores, lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, avoid_catches_without_on_clauses, inference_failure_on_function_return_type

import 'package:dio/dio.dart';

class RequestDataBuilder {
  static dynamic buildRequestData(
    dynamic body, {
    required bool formDataIsEnabled,
  }) {
    if (body is FormData) return body;
    if (formDataIsEnabled && body is Map<String, dynamic>) {
      return FormData.fromMap(body);
    }
    return body;
  }
}
