import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:flutter/material.dart';

class BannerHomeWidget extends StatelessWidget {
  const BannerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.width > 1200
          ? context.padding(
              horizontal: 90) // For very large screens (e.g., desktops)
          : context.width > 1000
              ? context.padding(horizontal: 80) // For large screens
              : context.width > 800
                  ? context.padding(horizontal: 70) // For medium-large screens
                  : context.width > 500
                      ? context.padding(horizontal: 50) // For medium screens
                      : context.padding(horizontal: 25), // For small screens
      child: Image.asset(
        'assets/images/Banner-home.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
