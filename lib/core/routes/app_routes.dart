import 'package:curai_app_mobile/core/app/onboarding/onboarding_screen.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/routes/base_routes.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/screens/under_build_screen.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/screens/book_appointment_screen.dart';
import 'package:curai_app_mobile/features/appointment/presentation/screens/payment_appointment_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/build_your_profile_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/change_password_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/otp_verifcation_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/help_center_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/settings_screen.dart';
import 'package:curai_app_mobile/features/reviews/presentation/screens/add_review_screen.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/screens/all_doctor_screen.dart';
import 'package:curai_app_mobile/features/home/presentation/screens/doctor_speciality_screen.dart';
import 'package:curai_app_mobile/features/layout/screens/main_scaffold_user.dart';
import 'package:curai_app_mobile/features/layout/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static Route<void> onGenerateRoute(RouteSettings settings) {
    final arg = settings.arguments;
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
        return BaseRoute(
          page: BlocProvider(
            create: (context) => sl<HomeCubit>(),
            child: const DoctorSpecialitiesScreen(),
          ),
        );
      case Routes.allDoctors:
        return BaseRoute(
          page: BlocProvider<HomeCubit>(
            create: (context) => sl<HomeCubit>(),
            child: AllDoctorScreen(specialityName: (arg ?? '') as String),
          ),
        );
      case Routes.settingsScreen:
        return BaseRoute(page: const SettingsScreen());
      case Routes.privacyPolicyScreen:
        return BaseRoute(page: const PrivacyPolicyScreen());
      case Routes.helpCenterScreen:
        return BaseRoute(page: const HelpCenterScreen());
      case Routes.addReviewScreen:
        return BaseRoute(
          page: AddReviewScreen(doctorId: arg! as int),
        );
      case Routes.bookAppointmentScreen:
        if (arg is Map<String, dynamic>) {
          final doctorResults = arg['doctorResults'] as DoctorResults?;
          final appointmentAvailableModel =
              arg['appointmentAvailableModel'] as AppointmentAvailableModel?;

          if (doctorResults != null && appointmentAvailableModel != null) {
            return BaseRoute(
              page: BookAppointmentScreen(
                doctorResults: doctorResults,
                appointmentAvailableModel: appointmentAvailableModel,
              ),
            );
          } else {
            return BaseRoute(page: const PageUnderBuildScreen());
          }
        }
        return BaseRoute(page: const PageUnderBuildScreen());

      case Routes.paymentAppointmentScreen:
        if (arg is Map<String, dynamic>) {
          final doctorResults = arg['doctorResults'] as DoctorResults?;
          final appointmentId = arg['appointmentId'] as int?;

          if (doctorResults != null && appointmentId != null) {
            return BaseRoute(
              page: PaymentAppointmentScreen(
                doctorResults: doctorResults,
                appointmentId: appointmentId,
              ),
            );
          } else {
            return BaseRoute(page: const PageUnderBuildScreen());
          }
        }
        return BaseRoute(page: const PageUnderBuildScreen());

      case Routes.yourProfileScreen:
        return BaseRoute(page: const BuildYourProfileScreen());
      default:
        return BaseRoute(page: const PageUnderBuildScreen());
    }
  }
}
