import 'package:flutter/material.dart';

class ErrorWidgetMain extends StatelessWidget {
  const ErrorWidgetMain({
    required this.details,
    super.key,
  });
  final FlutterErrorDetails details;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              details.summary.toString(),
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
