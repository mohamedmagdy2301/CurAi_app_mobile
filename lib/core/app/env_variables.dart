import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Enum to define environment types: development and production.

/// Singleton class to manage environment-specific variables using .env files.
///
/// This class loads the correct .env file based on the given environment type
/// and exposes key configuration variables for the application such as API base URL
/// and payment integration IDs.
///
/// Example usage:
/// ```dart
/// await EnvVariables().envVariablesSetup(envType: EnvTypeEnum.dev);
/// print(EnvVariables.baseApiUrl);
/// ```
class AppEnvironment {
  /// factory AppEnvironment() => _instance;
  factory AppEnvironment() => _instance;

  /// Private constructor for singleton pattern.
  AppEnvironment._();

  // Singleton instance
  static final AppEnvironment _instance = AppEnvironment._();

  /// Internal storage for the environment type (e.g., 'dev' or 'prod').
  String _envType = '';

  /// Base API URL loaded from the environment file.
  static String _baseApiUrl = '';

  /// Paymob API key used for payment integration.
  static String _apiKeyPaymob = '';

  /// Paymob card payment method integration ID.
  static String _cardPaymentMethodIntegrationId = '';

  /// Paymob wallet payment method integration ID.
  static String _walletPaymentMethodIntegrationId = '';

  /// Returns the dns sentry.
  static String _dsnSentry = '';

  /// Returns the current environment type.

  Future<void> _loadEnvFile() async {
    if (kDebugMode) {
      await dotenv.load(fileName: '.env.dev');
    } else {
      await dotenv.load(fileName: '.env.prod');
    }
  }

  /// Loads the corresponding `.env` file and populates the static fields.
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
  }

  /// Returns the base API URL.
  static String get baseApiUrl => _baseApiUrl;

  /// Returns the Paymob API key.
  static String get apiKeyPaymob => _apiKeyPaymob;

  /// Returns the integration ID for card payments.
  static String get cardPaymentMethodIntegrationId =>
      _cardPaymentMethodIntegrationId;

  /// Returns the integration ID for wallet payments.
  static String get walletPaymentMethodIntegrationId =>
      _walletPaymentMethodIntegrationId;

  /// Returns the Sentry DSN for error tracking.
  String get dsnSentry => _dsnSentry;

  /// Returns true if the app is running in development mode.
  bool get debugMode => _envType == 'dev';
}
