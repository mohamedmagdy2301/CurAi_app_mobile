import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.isStateArabic ? 'الاشعارات' : 'Notefication'),
        centerTitle: true,
      ),
    );
  }
}
