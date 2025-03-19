// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/features/auth/data/models/register_model/register_request.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<String, String>> register(RegisterRequest registerRequest);
}
