import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:flutter/material.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ColoredBox(
          color: const Color(0xfff7f7f7),
          child: Center(
            child: Image.asset(
              AppImages.noNetwork,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
