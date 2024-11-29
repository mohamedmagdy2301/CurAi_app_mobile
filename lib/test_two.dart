import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';

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
      body: Center(
        child: InkWell(
          onTap: () {
            context.pop();
          },
          child: const Text(
            'Smart Care 2',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
