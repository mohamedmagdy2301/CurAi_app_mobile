import 'package:curai_app_mobile/features/auth/presentation/widgets/your_profile/custom_appbar_your_profile.dart';
import 'package:flutter/material.dart';

class YourProfileScreen extends StatelessWidget {
  const YourProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarYourProfile(),
      body: Center(child: Text('Your Profile')),
    );
  }
}
