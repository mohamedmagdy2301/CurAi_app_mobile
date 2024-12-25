import 'package:curai_app_mobile/core/app/onboarding/onboarding_screen.dart';
import 'package:curai_app_mobile/core/common/screens/under_build_screen.dart';
import 'package:curai_app_mobile/core/routes/base_routes.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/otp_verifcation_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/all_doctor_screen.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/doctor_speciality_screen.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/main_scaffold_user.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<void> onGenerateRoute(RouteSettings settings) {
    // final arg = settings.arguments;
    switch (settings.name) {
      case Routes.mainScaffoldUser:
        return BaseRoute(page: const MainScaffoldUser());
      case Routes.onboarding:
        return BaseRoute(page: const Onboarding());
      case Routes.loginScreen:
        return BaseRoute(page: const LoginScreen());
      case Routes.registerScreen:
        return BaseRoute(page: const RegisterScreen());
      case Routes.forgetPasswordScreen:
        return BaseRoute(page: const ForgetPasswordScreen());
      case Routes.otpVerification:
        return BaseRoute(page: const OtpVerifcationScreen());
      case Routes.notificationScreen:
        return BaseRoute(page: const NotificationScreen());
      case Routes.doctorSpeciality:
        return BaseRoute(page: const DoctorSpecialitiesScreen());
      case Routes.allDoctors:
        return BaseRoute(page: const AllDoctorScreen());
      default:
        return BaseRoute(page: const PageUnderBuildScreen());
    }
  }
}
