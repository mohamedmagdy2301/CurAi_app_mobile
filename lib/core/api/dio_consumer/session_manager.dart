// ignore_for_file: strict_raw_type, document_ignores, lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, avoid_catches_without_on_clauses, inference_failure_on_function_return_type

import 'dart:async';

import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:flutter/material.dart';

class SessionManager {
  static Future<void> handleLogout() async {
    final context = di.sl<GlobalKey<NavigatorState>>().currentContext;

    if (context != null) {
      await AdaptiveDialogs.showLogoutAlertDialog(
        context: context,
        title: context.isStateArabic ? 'انتهت الجلسة' : 'Session Expired',
        message: context.isStateArabic
            ? 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.'
            : 'Your session has expired. Please log in again.',
        onPressed: () async {
          await clearUserData();
          await di
              .sl<CacheDataManager>()
              .removeData(key: SharedPrefKey.keyIsLoggedIn);
          if (context.mounted) {
            context.pop();
            await context.pushNamedAndRemoveUntil(Routes.loginScreen);
          }
        },
      );
    }
  }
}
