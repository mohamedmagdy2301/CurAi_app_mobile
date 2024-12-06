import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/features/user/presentation/screens/home.dart';
import 'package:smartcare_app_mobile/features/user/presentation/screens/setting_screen.dart';
import 'package:smartcare_app_mobile/features/user/presentation/widgets/custom_cupertino_tab_view.dart';

class MainScaffoldUser extends StatefulWidget {
  const MainScaffoldUser({super.key});

  @override
  State<MainScaffoldUser> createState() => _MainScaffoldUserState();
}

class _MainScaffoldUserState extends State<MainScaffoldUser> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: context.colors.primaryColor,
        iconSize: 28,
        items: tabBarItemList,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const CustomCupertinoTabView(screenTap: HomeScreen());
          case 1:
            return const CustomCupertinoTabView(screenTap: ProfileScreen());
          case 2:
            return const CustomCupertinoTabView(screenTap: ChatScreen());
          case 3:
            return const CustomCupertinoTabView(screenTap: SettingScreen());
          default:
            return const SizedBox();
        }
      },
    );
  }

  List<BottomNavigationBarItem> tabBarItemList = [
    const BottomNavigationBarItem(
      activeIcon: Icon(CupertinoIcons.house_alt_fill),
      icon: Icon(CupertinoIcons.house_alt),
    ),
    const BottomNavigationBarItem(
      activeIcon: Icon(CupertinoIcons.person_alt),
      icon: Icon(CupertinoIcons.person),
    ),
    const BottomNavigationBarItem(
      activeIcon: Icon(CupertinoIcons.chat_bubble_2_fill),
      icon: Icon(CupertinoIcons.chat_bubble),
    ),
    const BottomNavigationBarItem(
      activeIcon: Icon(Icons.settings),
      icon: Icon(CupertinoIcons.settings),
    ),
  ];
}
