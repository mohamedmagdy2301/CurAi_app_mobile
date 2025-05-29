import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  factory AppEnvironment() => _instance;

  AppEnvironment._();

  static final AppEnvironment _instance = AppEnvironment._();

  String _envType = '';
  String _baseApiUrl = '';
  String _apiKeyPaymob = '';
  String _cardPaymentMethodIntegrationId = '';
  String _walletPaymentMethodIntegrationId = '';
  String _dsnSentry = '';
  String _orsApiKey = '';

  Future<void> _loadEnvFile() async {
    if (kDebugMode) {
      await dotenv.load(fileName: '.env.dev');
    } else {
      await dotenv.load(fileName: '.env.prod');
    }
  }

  Future<void> initializeEnvironment() async {
    await _loadEnvFile();

    _envType = dotenv.get('ENV_TYPE');
    _baseApiUrl = dotenv.get('BASE_API_URL');
    _apiKeyPaymob = dotenv.get('API_KEY_PAYMOB');
    _cardPaymentMethodIntegrationId =
        dotenv.get('CARD_PAYMENT_METHOD_INTEGRATION_ID');
    _walletPaymentMethodIntegrationId =
        dotenv.get('WALLET_PAYMENT_METHOD_INTEGRATION_ID');
    _dsnSentry = dotenv.get('DSN_SENTRY');
    _orsApiKey = dotenv.get('ORS_API_KEY');
  }

  String get baseApiUrl => _baseApiUrl;
  String get apiKeyPaymob => _apiKeyPaymob;
  String get cardPaymentMethodIntegrationId => _cardPaymentMethodIntegrationId;
  String get walletPaymentMethodIntegrationId =>
      _walletPaymentMethodIntegrationId;
  String get dsnSentry => _dsnSentry;
  String get orsApiKey => _orsApiKey;
  bool get debugMode => _envType == 'dev';
}
