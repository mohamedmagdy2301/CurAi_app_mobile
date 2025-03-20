// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/features/auth/data/models/login/login_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/register/register_request.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<String, String>> register({
    required RegisterRequest registerRequest,
  });
  Future<Either<String, LoginModel>> login({
    required LoginRequest loginRequest,
  });
  Future<Either<String, String>> logout();
}
