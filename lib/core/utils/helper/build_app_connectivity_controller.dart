import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:flutter/material.dart';

GestureDetector setupConnectivityWidget(Widget? child) {
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
