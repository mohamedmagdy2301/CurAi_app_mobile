import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.isStateArabic ? 'الاشعارات' : 'Notefication'),
        centerTitle: true,
        flexibleSpace: Container(color: context.backgroundColor),
      ),
    );
  }
}
