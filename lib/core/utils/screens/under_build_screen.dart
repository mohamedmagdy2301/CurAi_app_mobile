import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:flutter/material.dart';

class PageUnderBuildScreen extends StatelessWidget {
  const PageUnderBuildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Center(
          child: Image.asset(
            AppImages.underBuild,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
