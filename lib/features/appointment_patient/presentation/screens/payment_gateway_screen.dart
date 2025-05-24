import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/services/payment/end_points_payment.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/payment_appointment/custom_appbar_payment_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:toastification/toastification.dart';

class PaymentGatewayScreen extends StatefulWidget {
  const PaymentGatewayScreen({required this.paymentToken, super.key});
  final String paymentToken;

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  InAppWebViewController? _webViewController;
  bool isLoading = true;

  void _startPayment() {
    _webViewController?.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(
          '${EndPointsPayment.getIframe}?payment_token=${widget.paymentToken}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarPaymentAppointment(),
      body: Stack(
        children: [
          InAppWebView(
            onWebViewCreated: (controller) {
              _webViewController = controller;
              _startPayment();
            },
            onLoadStop: (controller, url) {
              setState(() {
                isLoading = false;
              });

              if (url != null && url.queryParameters.containsKey('success')) {
                final isSuccess = url.queryParameters['success'] == 'true';
                showMessage(
                  context,
                  message: isSuccess
                      ? context.isStateArabic
                          ? 'تم الدفع بنجاح'
                          : 'Payment successful'
                      : context.isStateArabic
                          ? 'فشل الدفع'
                          : 'Payment failed',
                  type: isSuccess
                      ? ToastificationType.success
                      : ToastificationType.error,
                );
                Future<void>.delayed(const Duration(seconds: 1));
                isSuccess
                    ? context.pushNamed(Routes.mainScaffoldUser)
                    : context.pop();
              }
            },
          ),
          if (isLoading)
            const CustomLoadingWidget(height: 60, width: 60).center(),
        ],
      ),
    );
  }
}
