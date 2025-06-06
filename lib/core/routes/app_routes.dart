import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/routes/base_routes.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/screens/under_build_screen.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/screens/working_time_doctor_availble_screen.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/my_appointment_patient/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/screens/my_appointment_patient_screen.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/screens/payment_appointment_patient_screen.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/screens/payment_gateway_screen.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/screens/rescahedule_book_appointment_patient_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/add_address_clinic_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/bio_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/build_your_profile_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/change_password_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/complete_profile_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/otp_verifcation_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:curai_app_mobile/features/emergency/screens/emergency_screen.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/screens/doctor_speciality_screen.dart';
import 'package:curai_app_mobile/features/layout/screens/main_scaffold_user.dart';
import 'package:curai_app_mobile/features/onboarding/onboarding_screen.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/cubit/patient_history_cubit.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/screens/patient_history_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/favorites_doctor_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/help_center_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/settings_screen.dart';
import 'package:curai_app_mobile/features/search/presentation/cubit/search_doctor_cubit/search_doctor_cubit.dart';
import 'package:curai_app_mobile/features/search/presentation/screens/search_doctor_screen.dart';
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
      case Routes.paymentGatewayScreen:
        if (arg is Map<String, dynamic>) {
          final paymentToken = arg['paymentToken'] as String?;
          final appointmentId = arg['appointmentId'] as int;
          final discountApplied = arg['discountApplied'] as int;
          final isDiscountEnabled = arg['isDiscountEnabled'] as bool;
          return BaseRoute(
            page: BlocProvider(
              create: (context) => di.sl<AppointmentPatientCubit>(),
              child: PaymentGatewayScreen(
                paymentToken: paymentToken ?? '',
                appointmentId: appointmentId,
                discountApplied: discountApplied,
                isDiscountEnabled: isDiscountEnabled,
              ),
            ),
          );
        } else {
          return BaseRoute(page: const PageUnderBuildScreen());
        }
      case Routes.completeProfileScreen:
        return BaseRoute(page: const CompleteProfileScreen());
      case Routes.addAddreesClinicScreen:
        if (arg is Map<String, dynamic>) {
          final isEdit = arg['isEdit'] as bool?;
          return BaseRoute(
            page: AddAddressClinicScreen(isEdit: isEdit ?? false),
          );
        } else {
          return BaseRoute(page: const PageUnderBuildScreen());
        }
      case Routes.forgetPasswordScreen:
        return BaseRoute(page: const ForgetPasswordScreen());
      case Routes.favoriteScreen:
        return BaseRoute(
          page: const FavoriteDoctorsScreen(),
        );
      case Routes.otpVerification:
        return BaseRoute(page: const OtpVerifcationScreen());
      case Routes.changePasswordScreen:
        return BaseRoute(page: const ChangePasswordScreen());
      case Routes.doctorSpeciality:
        return BaseRoute(
          page: BlocProvider<HomeCubit>(
            create: (context) => di.sl<HomeCubit>(),
            child: const DoctorSpecialitiesScreen(),
          ),
        );
      case Routes.allDoctors:
        final specialityName = arg as String?;
        return BaseRoute(
          page: BlocProvider<SearchDoctorCubit>(
            create: (context) => di.sl<SearchDoctorCubit>(),
            child: SearchDoctorScreen(
              specialityName: specialityName,
            ),
          ),
        );
      case Routes.settingsScreen:
        return BaseRoute(page: const SettingsScreen());
      case Routes.emergencyDepartment:
        return BaseRoute(page: const EmergencyScreen());
      case Routes.privacyPolicyScreen:
        return BaseRoute(page: const PrivacyPolicyScreen());
      case Routes.helpCenterScreen:
        return BaseRoute(page: const HelpCenterScreen());
      case Routes.rescheduleAppointmentScreen:
        if (arg is Map<String, dynamic>) {
          final appointment = arg['appointment'] as ResultsMyAppointmentPatient;
          final doctorResults = arg['doctorResults'] as DoctorInfoModel?;

          if (doctorResults != null) {
            return BaseRoute(
              page: BlocProvider<AppointmentPatientCubit>(
                create: (context) => di.sl<AppointmentPatientCubit>(),
                child: RescaheduleBookAppointmentScreen(
                  appointment: appointment,
                  doctorResults: doctorResults,
                ),
              ),
            );
          } else {
            return BaseRoute(page: const PageUnderBuildScreen());
          }
        }
        return BaseRoute(page: const PageUnderBuildScreen());
      case Routes.patientHistoryScreen:
        if (arg is Map<String, dynamic>) {
          final patientId = arg['patientId'] as int;

          return BaseRoute(
            page: BlocProvider<PatientHistoryCubit>(
              create: (context) => di.sl<PatientHistoryCubit>(),
              child: PatientHistoryScreen(
                patientId: patientId,
              ),
            ),
          );
        }
        return BaseRoute(page: const PageUnderBuildScreen());

      case Routes.paymentAppointmentScreen:
        if (arg is Map<String, dynamic>) {
          final doctorResults = arg['doctorResults'] as DoctorInfoModel?;
          final appointmentId = arg['appointmentId'] as int?;

          if (doctorResults != null && appointmentId != null) {
            return BaseRoute(
              page: BlocProvider<AppointmentPatientCubit>(
                create: (context) => di.sl<AppointmentPatientCubit>(),
                child: PaymentAppointmentScreen(
                  doctorResults: doctorResults,
                  appointmentId: appointmentId,
                ),
              ),
            );
          } else {
            return BaseRoute(page: const PageUnderBuildScreen());
          }
        }
        return BaseRoute(page: const PageUnderBuildScreen());

      case Routes.myAppointmentPatientScreen:
        return BaseRoute(
          page: const MyAppointmentPatientScreen(),
        );
      case Routes.bioScreen:
        if (arg is Map<String, dynamic>) {
          final specialization = arg['specialization'] as String?;
          final isEdit = arg['isEdit'] as bool?;

          return BaseRoute(
            page: BioScreen(
              specialization: specialization,
              isEdit: isEdit ?? false,
            ),
          );
        }
        return BaseRoute(page: const PageUnderBuildScreen());

      case Routes.workingTimeDoctorAvailableScreen:
        return BaseRoute(
          page: const WorkingTimeDoctorAvailableScreen(),
        );
      case Routes.yourProfileScreen:
        return BaseRoute(
          page: BlocProvider(
            create: (context) => di.sl<AuthCubit>(),
            child: const BuildYourProfileScreen(),
          ),
        );
      default:
        return BaseRoute(page: const PageUnderBuildScreen());
    }
  }
}
