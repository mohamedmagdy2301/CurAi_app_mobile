import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Enum to define environment types: development and production.
enum EnvTypeEnum { dev, prod }

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

  /// Initializes the environment variables based on the specified [envType].
  ///
  /// Loads the corresponding `.env` file and populates the static fields.
  Future<void> initializeEnvironment({
    required EnvTypeEnum envType,
  }) async {
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

  /// Returns true if the app is running in development mode.
  bool get debugMode => _envType == 'dev';
}
