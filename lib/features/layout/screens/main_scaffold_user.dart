import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/screens/working_time_doctor_availble_screen.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/screens/my_appointment_patient_screen.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/screens/chatbot_screen.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/screens/all_doctor_screen.dart';
import 'package:curai_app_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:curai_app_mobile/features/layout/cubit/navigation_cubit.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScaffoldUser extends StatelessWidget {
  const MainScaffoldUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async {
              if (!didPop) {
                final shouldExit = await _showExitDialog(context);
                if (shouldExit && context.mounted) {
                  await Navigator.of(context).maybePop();
                }
              }
            },
            child: Scaffold(
              backgroundColor: context.backgroundColor,
              bottomNavigationBar: currentIndex == 2
                  ? null
                  : NavigationBar(
                      labelBehavior:
                          NavigationDestinationLabelBehavior.alwaysHide,
                      animationDuration: const Duration(seconds: 1),
                      height: context.H * 0.09,
                      indicatorColor: Colors.transparent,
                      backgroundColor: context.primaryColor.withAlpha(10),
                      overlayColor: WidgetStateProperty.all(
                        context.primaryColor.withAlpha(20),
                      ),
                      indicatorShape: Border.all(style: BorderStyle.none),
                      elevation: 0,
                      destinations: _buildDestinations(context),
                      selectedIndex: currentIndex,
                      onDestinationSelected: (index) {
                        context.read<NavigationCubit>().updateIndex(index);
                      },
                    ),
              body: _buildScreens(context)[currentIndex],
            ),
          );
        },
      ),
    );
  }

  /// Screens corresponding to each bottom nav destination
  List<Widget> _buildScreens(BuildContext context) {
    return [
      BlocProvider<HomeCubit>(
        create: (context) => di.sl<HomeCubit>(),
        child: const HomeScreen(),
      ),
      BlocProvider<HomeCubit>(
        create: (context) => di.sl<HomeCubit>(),
        child: const AllDoctorScreen(),
      ),
      const ChatbotScreen(),
      if (getRole() == 'doctor') const WorkingTimeDoctorAvailableScreen(),
      if (getRole() == 'patient') const MyAppointmentPatientScreen(),
      const ProfileScreen(),
    ];
  }

  Container customIconNavBar(
    BuildContext context, {
    double? size,
    double? sizeActive,
    bool isActive = false,
    IconData? icon,
    String? image,
  }) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: isActive
            ? context.onPrimaryColor.withAlpha(36)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(1002.r),
      ),
      child: icon != null
          ? Icon(
              icon,
              color:
                  !isActive ? context.onSecondaryColor : context.onPrimaryColor,
              size: size ?? 28.sp,
            )
          : (image != null)
              ? image.contains('svg')
                  ? SvgPicture.asset(
                      image,
                      colorFilter: ColorFilter.mode(
                        !isActive
                            ? context.onSecondaryColor
                            : context.onPrimaryColor,
                        BlendMode.srcIn,
                      ),
                      width: size ?? 28.sp,
                      height: size ?? 28.sp,
                    )
                  : Image.asset(
                      image,
                      color: !isActive
                          ? context.onSecondaryColor
                          : context.onPrimaryColor,
                      width: size ?? 28.sp,
                      height: size ?? 28.sp,
                    )
              : Container(),
    );
  }

  /// Navigation destinations for the bottom bar
  List<NavigationDestination> _buildDestinations(BuildContext context) {
    return [
      NavigationDestination(
        icon: customIconNavBar(
          context,
          size: 26.sp,
          image: 'assets/svg/layout/home.svg',
        ),
        selectedIcon: customIconNavBar(
          context,
          isActive: true,
          size: 26.sp,
          image: 'assets/svg/layout/home2.svg',
        ),
        label: 'Home',
      ),
      NavigationDestination(
        icon: customIconNavBar(
          context,
          image: 'assets/svg/layout/search.svg',
        ),
        selectedIcon: customIconNavBar(
          context,
          isActive: true,
          image: 'assets/svg/layout/search2.svg',
        ),
        label: 'Search',
      ),
      NavigationDestination(
        icon: customIconNavBar(context, icon: CupertinoIcons.chat_bubble),
        selectedIcon: customIconNavBar(
          context,
          isActive: true,
          icon: CupertinoIcons.chat_bubble_fill,
        ),
        label: 'Chat',
      ),
      NavigationDestination(
        icon: customIconNavBar(
          context,
          image: 'assets/svg/layout/calendar.svg',
        ),
        selectedIcon: customIconNavBar(
          context,
          isActive: true,
          image: 'assets/svg/layout/calendar2.svg',
        ),
        label: 'Appointment',
      ),
      NavigationDestination(
        icon: customIconNavBar(
          context,
          image: 'assets/svg/layout/profile.svg',
        ),
        selectedIcon: customIconNavBar(
          context,
          isActive: true,
          image: 'assets/svg/layout/profile2.svg',
        ),
        label: 'Profile',
      ),
    ];
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    final isArabic = context.isStateArabic;

    return await AdaptiveDialogs.showOkCancelAlertDialog<bool>(
          context: context,
          title: isArabic ? 'تأكيد الخروج' : 'Exit Confirmation',
          message: isArabic ? 'هل ترغب في الخروج؟' : 'Do you want to exit?',
          onPressedCancel: () => Navigator.of(context).pop(false),
          onPressedOk: () => Navigator.of(context).pop(true),
        ) ??
        false;
  }
}
