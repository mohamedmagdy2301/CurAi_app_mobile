import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';

class ErrorWidgetMain extends StatelessWidget {
  const ErrorWidgetMain({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            spaceHeight(10),
            const Text(
              'An error has occurred',
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
