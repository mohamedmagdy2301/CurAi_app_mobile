import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:flutter/material.dart';

Widget setupConnectivityWidget(Widget child) {
  return GestureDetector(
    onTap: hideKeyboard,
    child: Builder(
      builder: (context) {
        sl<ConnectivityController>().connectivityControllerInit();

        return LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            const maxContentWidth = 500.0;

            final shouldConstrain = screenWidth > maxContentWidth;

            final constrainedContent = shouldConstrain
                ? Center(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: maxContentWidth),
                      child: child,
                    ),
                  )
                : child;

            return Scaffold(
              body: constrainedContent,
            );
          },
        );
      },
    ),
  );
}
