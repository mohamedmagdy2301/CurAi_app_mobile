// ignore: lines_longer_than_80_chars
// ignore_for_file: inference_failure_on_function_invocation, avoid_dynamic_calls, document_ignores

import 'package:curai_app_mobile/core/app/env_variables.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/services/payment/end_points_payment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PaymobManager {
  factory PaymobManager() => _instance;
  PaymobManager._();
  static final PaymobManager _instance = PaymobManager._();

  static final Dio _dio = Dio();
  static Future<String> getCreditCardPaymentKey(int amount) async {
    if (kDebugMode) {
      _dio.interceptors.add(di.sl<LogInterceptor>());
    }
    try {
      final authanticationToken = await _getAuthanticationToken();

      final orderId = await _getOrderId(
        authanticationToken: authanticationToken,
        amount: (100 * amount).toString(),
      );

      final paymentKey = await _getPaymentKey(
        authanticationToken: authanticationToken,
        amount: (100 * amount).toString(),
        orderId: orderId.toString(),
      );
      return paymentKey;
    } on Exception catch (_) {
      throw Exception();
    }
  }

  static Future<String> _getAuthanticationToken() async {
    final response = await _dio.post(
      EndPointsPayment.getAuthanticationToken,
      data: {
        'api_key': di.sl<AppEnvironment>().apiKeyPaymob,
      },
    );
    return response.data['token'] as String;
  }

  static Future<int> _getOrderId({
    required String authanticationToken,
    required String amount,
  }) async {
    final response = await _dio.post(
      EndPointsPayment.getOrderId,
      data: {
        'auth_token': authanticationToken,
        'amount_cents': amount,
        'currency': 'EGP',
        'delivery_needed': 'false',
        'items': <dynamic>[],
      },
    );
    return response.data['id'] as int;
  }

  static Future<String> getWalletPaymentKey(int amount) async {
    if (kDebugMode) {
      _dio.interceptors.add(di.sl<LogInterceptor>());
    }
    try {
      final authanticationToken = await _getAuthanticationToken();

      final orderId = await _getOrderId(
        authanticationToken: authanticationToken,
        amount: (100 * amount).toString(),
      );

      final paymentKey = await _getPaymentKey(
        authanticationToken: authanticationToken,
        amount: (100 * amount).toString(),
        orderId: orderId.toString(),
        isWallet: true,
      );
      return paymentKey;
    } on Exception catch (_) {
      throw Exception();
    }
  }

  static Future<String> _getPaymentKey({
    required String authanticationToken,
    required String orderId,
    required String amount,
    bool isWallet = false,
  }) async {
    final response = await _dio.post(
      EndPointsPayment.getPaymentKey,
      data: {
        'expiration': 3600,
        'auth_token': authanticationToken,
        'order_id': orderId,
        'integration_id': isWallet
            ? di.sl<AppEnvironment>().walletPaymentMethodIntegrationId
            : di.sl<AppEnvironment>().cardPaymentMethodIntegrationId,
        'amount_cents': amount,
        'currency': 'EGP',
        'billing_data': {
          'first_name': 'Clifford',
          'last_name': 'Nicolas',
          'email': 'claudette09@exa.com',
          'phone_number': '+86(8)9135210487',
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
