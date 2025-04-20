import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/screens/chatbot_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/navigation_cubit.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/home_screen.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScaffoldUser extends StatelessWidget {
  const MainScaffoldUser({super.key});

  @override
  Widget build(BuildContext context) {
    final destinations = [
      NavigationDestination(
        icon: Icon(CupertinoIcons.house_alt, size: 25.sp),
        selectedIcon:
            selectedIconCustom(CupertinoIcons.house_alt_fill, context),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(CupertinoIcons.chat_bubble, size: 25.sp),
        selectedIcon:
            selectedIconCustom(CupertinoIcons.chat_bubble_fill, context),
        label: 'Chat',
      ),
      NavigationDestination(
        icon: Icon(CupertinoIcons.bell, size: 25.sp),
        selectedIcon: selectedIconCustom(CupertinoIcons.bell_solid, context),
        label: 'Notification',
      ),
      NavigationDestination(
        icon: Icon(CupertinoIcons.person, size: 25.sp),
        selectedIcon: selectedIconCustom(CupertinoIcons.person_alt, context),
        label: 'Profile',
      ),
    ];

    const screens = [
      HomeScreen(),
      ChatbotScreen(),
      NotificationScreen(),
      ProfileScreen(),
    ];

    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
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
      ),
    );
  }

  Column selectedIconCustom(IconData icon, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(icon, color: context.primaryColor, size: 28.sp),
        15.hSpace,
        Divider(
          height: 1.sp,
          thickness: 3,
          color: context.primaryColor,
          indent: 30.w,
          endIndent: 30.w,
        ),
        15.hSpace,
      ],
    );
  }
}
