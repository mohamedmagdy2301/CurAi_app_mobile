import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
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

  @override
  void initState() {
    super.initState();
    _startPayment();
  }

  void _startPayment() {
    _webViewController?.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(
          'https://accept.paymob.com/api/acceptance/iframes/925548?payment_token=${widget.paymentToken}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Gateway'),
      ),
      body: InAppWebView(
        onWebViewCreated: (controller) {
          _webViewController = controller;
          _startPayment();
        },
        onLoadStop: (controller, url) {
          // You can handle the URL after the payment is completed here
          if (url != null &&
              url.queryParameters.containsKey('success') &&
              url.queryParameters['success'] == 'true') {
            // Handle success
            showMessage(
              context,
              message: 'success payment',
              type: ToastificationType.success,
            );
          } else if (url != null &&
              url.queryParameters.containsKey('success') &&
              url.queryParameters['success'] == 'false') {
            // Handle failure
            showMessage(
              context,
              message: 'payment failed',
              type: ToastificationType.error,
            );
          }
        },
      ),
    );
  }
}
  //   Future<void> _pay() async {
  //   PaymobManager()
  //       .getPaymentKey(
  //     10,
  //     'EGP',
  //   )
  //       .then((String paymentKey) {
  //     launchUrl(
  //       Uri.parse(
  //         'https://accept.paymob.com/api/acceptance/iframes/925548?payment_token=$paymentKey',
  //       ),
  //     );
  //   });
  // }