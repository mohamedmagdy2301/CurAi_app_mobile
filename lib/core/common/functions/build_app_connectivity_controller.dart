import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/di/dependency_injection.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:flutter/material.dart';

GestureDetector buildAppConnectivityController(Widget? child) {
  return GestureDetector(
    onTap: hideKeyboard,
    child: Scaffold(
      body: Builder(
        builder: (context) {
          sl<ConnectivityController>().connectivityControllerInit();
          return child!;
        },
      ),
    ),
  );
}
