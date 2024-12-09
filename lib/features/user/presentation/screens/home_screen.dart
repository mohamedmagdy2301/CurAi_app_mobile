import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/features/user/presentation/widgets/custom_appbar_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: spaceHeight(20)),
          const CustomAppBarHome(),
          SliverToBoxAdapter(child: spaceHeight(20)),
          const SliverToBoxAdapter(
            child: Center(
              child: Text('Home Screen'),
            ),
          ),
        ],
      ),
    );
  }
}
