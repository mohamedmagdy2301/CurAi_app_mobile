import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/features/user/presentation/screens/home.dart';
import 'package:smartcare_app_mobile/features/user/presentation/screens/home_screen.dart';
import 'package:smartcare_app_mobile/features/user/presentation/screens/setting_screen.dart';

class MainScaffoldUser extends StatefulWidget {
  const MainScaffoldUser({super.key});

  @override
  State<MainScaffoldUser> createState() => _MainScaffoldUserState();
}

class _MainScaffoldUserState extends State<MainScaffoldUser> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final destinations = [
      NavigationDestination(
        icon: const Icon(CupertinoIcons.house_alt),
        selectedIcon: selectedIconCustom(CupertinoIcons.house_alt_fill),
        label: 'Home',
      ),
      NavigationDestination(
        icon: const Icon(CupertinoIcons.chat_bubble),
        selectedIcon: selectedIconCustom(CupertinoIcons.chat_bubble_fill),
        label: 'Chat',
      ),
      NavigationDestination(
        icon: const Icon(CupertinoIcons.bell),
        selectedIcon: selectedIconCustom(CupertinoIcons.bell_solid),
        label: 'Notif',
      ),
      NavigationDestination(
        icon: const Icon(CupertinoIcons.gear),
        selectedIcon: selectedIconCustom(CupertinoIcons.gear_alt_fill),
        label: 'Setting',
      ),
    ];
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          elevation: 0,
          animationDuration: const Duration(seconds: 1),
          height: 60.h,
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateProperty.all(
            context.colors.onboardingBg!.withOpacity(.3),
          ),
          indicatorShape: Border.all(style: BorderStyle.none),
          destinations: destinations,
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _buildScreens,
        ),
      ),
    );
  }

  Column selectedIconCustom(IconData icon) {
    return Column(
      children: [
        Divider(
          height: 2,
          thickness: 2.5,
          color: context.colors.primaryColor,
        ),
        spaceHeight(15),
        Icon(icon, color: context.colors.primaryColor),
      ],
    );
  }

  final List<Widget> _buildScreens = [
    const HomeScreen(),
    const ProfileScreen(),
    const ChatScreen(),
    const SettingScreen(),
  ];
}
