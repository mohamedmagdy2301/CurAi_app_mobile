import 'package:curai_app_mobile/core/app/onboarding/onboarding_screen.dart';
import 'package:curai_app_mobile/core/routes/base_routes.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/screens/under_build_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/change_password_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/otp_verifcation_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/your_profile_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/settings_screen.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/all_doctor_screen.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/doctor_speciality_screen.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/main_scaffold_user.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/notification_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<void> onGenerateRoute(RouteSettings settings) {
    // final arg = settings.arguments;
    switch (settings.name) {
      case Routes.mainScaffoldUser:
        return BaseRoute(page: const MainScaffoldUser());
      case Routes.onboarding:
        return BaseRoute(page: const OnboardingScreen());
      case Routes.loginScreen:
        return BaseRoute(page: const LoginScreen());
      case Routes.registerScreen:
        return BaseRoute(page: const RegisterScreen());
      case Routes.forgetPasswordScreen:
        return BaseRoute(page: const ForgetPasswordScreen());
      case Routes.otpVerification:
        return BaseRoute(page: const OtpVerifcationScreen());
      case Routes.changePasswordScreen:
        return BaseRoute(page: const ChangePasswordScreen());
      case Routes.notificationScreen:
        return BaseRoute(page: const NotificationScreen());
      case Routes.doctorSpeciality:
        return BaseRoute(page: const DoctorSpecialitiesScreen());
      case Routes.allDoctors:
        return BaseRoute(page: const AllDoctorScreen());
      case Routes.settingsScreen:
        return BaseRoute(page: const SettingsScreen());
      case Routes.yourProfileScreen:
        return BaseRoute(page: const YourProfileScreen());
      default:
        return BaseRoute(page: const PageUnderBuildScreen());
    }
  }
}
