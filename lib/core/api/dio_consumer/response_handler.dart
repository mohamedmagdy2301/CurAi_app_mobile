import 'dart:async';
import 'dart:convert';

import 'package:curai_app_mobile/core/api/dio_consumer/session_manager.dart';
import 'package:curai_app_mobile/core/api/dio_consumer/token_manager.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:curai_app_mobile/core/api/status_code.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ResponseHandler {
  static Future<Either<Failure, dynamic>> handleResponse(
    Response<dynamic> response,
    Future<Response<dynamic>> Function()? retryRequest,
  ) async {
    if (response.statusCode == StatusCode.okNoContent) {
      return right(<String, dynamic>{});
    }

    final dynamic data = await _parseResponseData(response);

    // Handle successful responses
    if (_isSuccessfulResponse(response.statusCode!)) {
      return right(data);
    }

    // Handle permission errors
    if (_isPermissionError(response.statusCode!, data)) {
      if (data is! Map) return left(ServerFailure('Permission denied'));
      return left(ServerFailure(data['detail'] as String));
    }

    // Handle authorization issues
    if (_requiresTokenRefresh(response.statusCode!, data)) {
      return _handleTokenRefresh(retryRequest);
    }

    return left(ServerFailure.fromBadResponse(response.statusCode!, data));
  }

  static Future<dynamic> _parseResponseData(Response<dynamic> response) async {
    try {
      if (response.data != null && response.data.toString().trim().isNotEmpty) {
        return response.data is String
            ? jsonDecode(response.data as String)
            : response.data;
      } else {
        return <String, dynamic>{};
      }
    } on Exception catch (_) {
      return response.data;
    }
  }

  static bool _isSuccessfulResponse(int statusCode) {
    return statusCode == StatusCode.ok || statusCode == StatusCode.okCreated;
  }

  static bool _isPermissionError(int statusCode, dynamic data) {
    if (data is! Map) return false;
    return statusCode == StatusCode.forbidden &&
        data['detail'].toString().toLowerCase().contains('permission');
  }

  static bool _requiresTokenRefresh(int statusCode, dynamic data) {
    if (statusCode == StatusCode.unauthorized ||
        statusCode == StatusCode.forbidden) {
      if (data is Map) {
        return TokenManager.isJwtExpired(data);
      }
    }
    return false;
  }

  static Future<Either<Failure, dynamic>> _handleTokenRefresh(
    Future<Response<dynamic>> Function()? retryRequest,
  ) async {
    if (TokenManager.isRefreshing) {
      return _queueRequest(retryRequest);
    }

    if (getRefreshToken().isNotEmpty) {
      final refreshed = await TokenManager.refreshToken(getRefreshToken());
      if (refreshed && retryRequest != null) {
        final retriedResponse = await retryRequest();
        return handleResponse(retriedResponse, null);
      } else {
        await SessionManager.handleLogout();
      }
    }

    return left(ServerFailure('Authentication failed'));
  }

  static Future<Either<Failure, dynamic>> _queueRequest(
    Future<Response<dynamic>> Function()? retryRequest,
  ) async {
    final completer = Completer<Either<Failure, dynamic>>();
    TokenManager.addToQueue(() async {
      try {
        final retried = await retryRequest!();
        final result = await handleResponse(retried, null);
        completer.complete(result);
      } on Exception catch (e) {
        completer.complete(left(ServerFailure(e.toString())));
      }
    });
    return completer.future;
  }
}
