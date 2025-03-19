import 'package:curai_app_mobile/core/error/failure.dart';
import 'package:curai_app_mobile/features/auth/data/models/register_model/register_request.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, String>> register(RegisterRequest registerRequest);
}
