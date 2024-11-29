import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/styles/images/app_images.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImages.noNetwork,
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}