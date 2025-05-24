class EndPointsPayment {
  EndPointsPayment._();

  static const String getAuthanticationToken =
      'https://accept.paymob.com/api/auth/tokens';
  static const String getOrderId =
      'https://accept.paymob.com/api/ecommerce/orders';
  static const String getPaymentKey =
      'https://accept.paymob.com/api/acceptance/payment_keys';

  static const String getIframe =
      'https://accept.paymob.com/api/acceptance/iframes/925548';
}
