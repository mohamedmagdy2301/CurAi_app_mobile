import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          // floating: true,
          // snap: true,
          pinned: true,
          title: Text('Home Screen'),
          automaticallyImplyLeading: false,
        ),
        SliverToBoxAdapter(child: spaceHeight(20)),
        const SliverToBoxAdapter(
          child: Center(
            child: Text('Home Screen'),
          ),
        ),
      ],
    );
  }
}
