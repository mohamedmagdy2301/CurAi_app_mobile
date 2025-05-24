import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvTypeEnum { dev, prod }

class EnvVariables {
  String _envType = '';
  static String _baseApiUrl = '';
  static String _apiKeyPaymob = '';
  static String _cardPaymentMethodIntegrationId = '';
  static String _walletPaymentMethodIntegrationId = '';

  Future<void> envVariablesSetup({required EnvTypeEnum envType}) async {
    switch (envType) {
      case EnvTypeEnum.dev:
        await dotenv.load(fileName: '.env.dev');
      case EnvTypeEnum.prod:
        await dotenv.load(fileName: '.env.prod');
    }
    _envType = dotenv.get('ENV_TYPE');
    _baseApiUrl = dotenv.get('BASE_API_URL');
    _apiKeyPaymob = dotenv.get('API_KEY_PAYMOB');
    _cardPaymentMethodIntegrationId =
        dotenv.get('CARD_PAYMENT_METHOD_INTEGRATION_ID');
    _walletPaymentMethodIntegrationId =
        dotenv.get('WALLET_PAYMENT_METHOD_INTEGRATION_ID');
  }

  static String get baseApiUrl => _baseApiUrl;
  static String get apiKeyPaymob => _apiKeyPaymob;
  static String get cardPaymentMethodIntegrationId =>
      _cardPaymentMethodIntegrationId;

  static String get walletPaymentMethodIntegrationId =>
      _walletPaymentMethodIntegrationId;

  // String get envType => _envType;
  bool get debugMode => _envType == 'dev';
}
