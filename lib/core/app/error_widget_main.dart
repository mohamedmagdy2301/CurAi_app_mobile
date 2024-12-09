import 'package:flutter/material.dart';

class ErrorWidgetMain extends StatelessWidget {
  const ErrorWidgetMain({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
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
