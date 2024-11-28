import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/app/connectivity_controller.dart';
import 'package:smartcare_app_mobile/core/common/screens/no_internet_connection.dart';

class SmartCareApp extends StatelessWidget {
  const SmartCareApp({required this.environment, super.key});
  final bool environment;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          ConnectivityController.instance.isInternetConnectedNotifier,
      builder: (_, value, __) {
        if (value) {
          return MaterialApp(
            debugShowCheckedModeBanner: environment,
            builder: (context, child) {
              return Scaffold(
                body: Builder(
                  builder: (context) {
                    ConnectivityController.instance.init();
                    return child!;
                  },
                ),
              );
            },
            home: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text(
                  'Smart Care',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor:
                    environment ? Colors.green : Colors.amberAccent,
              ),
              body: const Center(
                child: Text(
                  'Smart Care',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }
        return const NoInternetConnection();
      },
    );
  }
}
