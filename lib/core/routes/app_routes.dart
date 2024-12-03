import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/app/onboarding/onboarding_screen.dart';
import 'package:smartcare_app_mobile/core/common/screens/under_build_screen.dart';
import 'package:smartcare_app_mobile/core/routes/base_routes.dart';
import 'package:smartcare_app_mobile/core/routes/routes.dart';
import 'package:smartcare_app_mobile/test_one.dart';

class AppRoutes {
  static Route<void> onGenerateRoute(RouteSettings settings) {
    // final arg = settings.arguments;
    switch (settings.name) {
      case Routes.testone:
        return BaseRoute(page: const TestOne());
      case Routes.onboarding:
        return BaseRoute(page: const Onboarding());
      default:
        return BaseRoute(page: const PageUnderBuildScreen());
    }
  }
}
