import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/fonts_family_helper.dart';

class TestTwo extends StatelessWidget {
  const TestTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Care 2',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Smart Care ',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Smart Care ',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: FontsFamilyHelper.poppinsEn,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'المرحلة الثانية',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeightHelper.medium,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'المرحلة الثانية',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: FontsFamilyHelper.cairoAr,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                context.assets.testImageTheme!,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
