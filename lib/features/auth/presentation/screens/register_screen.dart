import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: padding(horizontal: 20, vertical: 20),
          child: const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
    );
  }
}
