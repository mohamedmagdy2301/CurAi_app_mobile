import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvTypeEnum { dev, prod }

class EnvVariables {
  String _envType = '';
  static String _baseApiUrl = '';
  Future<void> envVariablesSetup({required EnvTypeEnum envType}) async {
    switch (envType) {
      case EnvTypeEnum.dev:
        await dotenv.load(fileName: '.env.dev');
      case EnvTypeEnum.prod:
        await dotenv.load(fileName: '.env.prod');
    }
    _envType = dotenv.get('ENV_TYPE');
    _baseApiUrl = dotenv.get('BASE_API_URL');
  }

  static String get baseApiUrl => _baseApiUrl;

  // String get envType => _envType;
  bool get debugMode => _envType == 'dev';
}
