import 'package:curai_app_mobile/core/app/onboarding/onboarding_screen.dart';
import 'package:curai_app_mobile/core/routes/base_routes.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/screens/under_build_screen.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/screens/working_time_doctor_availble_screen.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/appointment_patient_available/appointment_patient_available_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/screens/book_appointment_patient_screen.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/screens/my_appointment_patient_screen.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/screens/payment_appointment_patient_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/build_your_profile_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/change_password_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/otp_verifcation_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/presentation/screens/all_doctor_screen.dart';
import 'package:curai_app_mobile/features/home/presentation/screens/doctor_speciality_screen.dart';
import 'package:curai_app_mobile/features/layout/screens/main_scaffold_user.dart';
import 'package:curai_app_mobile/features/layout/screens/notification_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/help_center_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/settings_screen.dart';
import 'package:curai_app_mobile/features/reviews/presentation/screens/add_review_screen.dart';
import 'package:flutter/material.dart';

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
          page: const DoctorSpecialitiesScreen(),
        );
      case Routes.allDoctors:
        return BaseRoute(
          page: AllDoctorScreen(specialityName: (arg ?? '') as String),
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
          final appointmentId = arg['appointmentId'] as int?;
          final doctorResults = arg['doctorResults'] as DoctorResults?;
          final appointmentAvailableModel = arg['appointmentAvailableModel']
              as AppointmentPatientAvailableModel?;

          final isReschedule = arg['isReschedule'] as bool;

          if (doctorResults != null && appointmentAvailableModel != null) {
            return BaseRoute(
              page: BookAppointmentPatientScreen(
                isReschedule: isReschedule,
                appointmentId: appointmentId,
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

      case Routes.myAppointmentPatientScreen:
        return BaseRoute(page: const MyAppointmentPatientScreen());
      case Routes.workingTimeDoctorAvailableScreen:
        return BaseRoute(page: const WorkingTimeDoctorAvailableScreen());
      case Routes.yourProfileScreen:
        return BaseRoute(page: const BuildYourProfileScreen());
      default:
        return BaseRoute(page: const PageUnderBuildScreen());
    }
  }
}
