import 'package:flutter/material.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';

class BannerHomeWidget extends StatelessWidget {
  const BannerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(horizontal: 20),
      child: Image.asset(
        'assets/images/Banner-home.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
