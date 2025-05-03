import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/screens/working_time_doctor_availble_screen.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/screens/my_appointment_patient_screen.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/screens/chatbot_screen.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit.dart';
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
    final destinations = [
      NavigationDestination(
        icon: customIconNavBar(
          context,
          icon: CupertinoIcons.house_alt,
        ),
        selectedIcon: customIconNavBar(
          context,
          isActive: true,
          icon: CupertinoIcons.house_alt_fill,
        ),
        label: 'Home',
      ),
      NavigationDestination(
        icon: customIconNavBar(
          context,
          icon: CupertinoIcons.chat_bubble,
        ),
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
        label: 'Notification',
      ),
      NavigationDestination(
        icon: customIconNavBar(
          context,
          icon: CupertinoIcons.person,
        ),
        selectedIcon: customIconNavBar(
          context,
          isActive: true,
          icon: CupertinoIcons.person_alt,
        ),
        label: 'Chat',
      ),
    ];

    final screens = [
      BlocProvider<HomeCubit>(
        create: (context) => di.sl<HomeCubit>(),
        child: const HomeScreen(),
      ),
      const ChatbotScreen(),
      if (isDoctor) const WorkingTimeDoctorAvailableScreen(),
      if (isPatient) const MyAppointmentPatientScreen(),
      const ProfileScreen(),
    ];

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: context.backgroundColor,
            bottomNavigationBar: currentIndex == 1
                ? null
                : NavigationBar(
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysHide,
                    animationDuration: const Duration(seconds: 1),
                    height: 60.sp,
                    indicatorColor: Colors.transparent,
                    backgroundColor: context.backgroundColor,
                    overlayColor: WidgetStateProperty.all(
                      context.primaryColor.withAlpha(20),
                    ),
                    indicatorShape: Border.all(style: BorderStyle.none),
                    elevation: 0,
                    destinations: destinations,
                    selectedIndex: currentIndex,
                    onDestinationSelected: (index) {
                      context.read<NavigationCubit>().updateIndex(index);
                    },
                  ),
            body: screens[currentIndex],
          ),
        );
      },
    );
  }

  Column customIconNavBar(
    BuildContext context, {
    bool isIcon = true,
    bool isActive = false,
    IconData? icon,
    String? image,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isActive) 10.hSpace else 0.hSpace,
        if (isIcon == true && icon != null)
          Icon(
            icon,
            color: !isActive ? context.onSecondaryColor : context.primaryColor,
            size: 28.sp,
          )
        else if (image != null)
          SvgPicture.asset(
            image,
            colorFilter: ColorFilter.mode(
              !isActive ? context.onSecondaryColor : context.primaryColor,
              BlendMode.srcIn,
            ),
            width: 28.sp,
            height: 28.sp,
          )
        else
          const SizedBox(),
        if (isActive == true) ...[
          Divider(
            height: 20.sp,
            thickness: 3,
            color: context.primaryColor,
            indent: 30.w,
            endIndent: 30.w,
          ),
        ],
      ],
    );
  }
}
