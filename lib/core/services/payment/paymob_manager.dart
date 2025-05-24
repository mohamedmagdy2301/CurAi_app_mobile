import 'dart:developer';

import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:dio/dio.dart';

class PaymobManager {
  Future<String> getPaymentKey(int amount, String currency) async {
    try {
      final authanticationToken = await _getAuthanticationToken();

      final orderId = await _getOrderId(
        authanticationToken: authanticationToken,
        amount: (100 * amount).toString(),
        currency: currency,
      );

      final paymentKey = await _getPaymentKey(
        authanticationToken: authanticationToken,
        amount: (100 * amount).toString(),
        currency: currency,
        orderId: orderId.toString(),
      );
      return paymentKey;
    } catch (e) {
      log('Exc==========================================');
      log(e.toString());
      throw Exception();
    }
  }

  Future<String> _getAuthanticationToken() async {
    final response = await Dio().post(
      'https://accept.paymob.com/api/auth/tokens',
      data: {
        'api_key': EnvVariables.apiKeyPaymob,
      },
    );
    return response.data['token'] as String;
  }

  Future<int> _getOrderId({
    required String authanticationToken,
    required String amount,
    required String currency,
  }) async {
    final response = await Dio().post(
      'https://accept.paymob.com/api/ecommerce/orders',
      data: {
        'auth_token': authanticationToken,
        'amount_cents': amount,
        'currency': currency,
        'delivery_needed': 'false',
        'items': [],
      },
    );
    return response.data['id'] as int;
  }

  Future<String> _getPaymentKey({
    required String authanticationToken,
    required String orderId,
    required String amount,
    required String currency,
  }) async {
    final response = await Dio().post(
      'https://accept.paymob.com/api/acceptance/payment_keys',
      data: {
        //ALL OF THEM ARE REQIERD
        'expiration': 3600,

        'auth_token': authanticationToken,
        'order_id': orderId,
        'integration_id': EnvVariables.cardPaymentMethodIntegrationId,

        'amount_cents': amount,
        'currency': currency,

        'billing_data': {
          //Have To Be Values
          'first_name': 'Clifford',
          'last_name': 'Nicolas',
          'email': 'claudette09@exa.com',
          'phone_number': '+86(8)9135210487',

          //Can Set "NA"
          'apartment': 'NA',
          'floor': 'NA',
          'street': 'NA',
          'building': 'NA',
          'shipping_method': 'NA',
          'postal_code': 'NA',
          'city': 'NA',
          'country': 'NA',
          'state': 'NA',
        },
      },
    );
    return response.data['token'] as String;
  }
}
