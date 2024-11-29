import 'package:flutter/material.dart';
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
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.amberAccent,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Smart Care ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Smart Care ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: FontsFamilyHelper.poppinsEn,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'المرحلة الثانية',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeightHelper.medium,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'المرحلة الثانية',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: FontsFamilyHelper.cairoAr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
