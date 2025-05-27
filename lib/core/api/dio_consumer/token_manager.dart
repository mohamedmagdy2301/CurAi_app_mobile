// ignore_for_file: strict_raw_type, document_ignores, lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, avoid_catches_without_on_clauses, inference_failure_on_function_return_type

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:curai_app_mobile/core/api/dio_consumer/dio_configurator.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/app/env_variables.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// 1. Token Manager - لإدارة التوكينات وعملية التحديث
class TokenManager {
  static bool _isRefreshing = false;
  static final List<Function()> _refreshQueue = [];

  static bool get isRefreshing => _isRefreshing;

  static Future<bool> refreshToken(String refreshToken) async {
    if (_isRefreshing) return false;

    _isRefreshing = true;
    try {
      final refreshDio = Dio();
      DioConfigurator.configure(refreshDio);

      final response = await refreshDio.post(
        '${di.sl<AppEnvironment>().baseApiUrl}${EndPoints.refreshToken}',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = response.data is String
            ? jsonDecode(response.data as String)
            : response.data;

        if (decoded is Map && decoded.containsKey('access')) {
          final newAccessToken = decoded['access'];
          await di.sl<CacheDataManager>().setData(
                key: SharedPrefKey.keyAccessToken,
                value: newAccessToken,
              );

          await _processQueue();
          return true;
        }
      }
    } catch (e) {
      if (kDebugMode) log('Exception during token refresh: $e');
    } finally {
      _isRefreshing = false;
    }

    return false;
  }

  static void addToQueue(Function() request) {
    _refreshQueue.add(request);
  }

  static Future<void> _processQueue() async {
    while (_refreshQueue.isNotEmpty) {
      final request = _refreshQueue.removeAt(0);
      await request();
    }
  }

  static bool isJwtExpired(Map data) {
    final detail = data['detail']?.toString().toLowerCase() ?? '';
    final code = data['code']?.toString().toLowerCase() ?? '';
    return detail.contains('invalid') ||
        detail.contains('expired') ||
        code.contains('token_not_valid');
  }
}
