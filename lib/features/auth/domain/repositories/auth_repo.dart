import 'package:curai_app_mobile/features/auth/data/models/register_model/register_request.dart';

abstract class AuthRepo {
  Future<String> register(RegisterRequest registerRequest);
}
