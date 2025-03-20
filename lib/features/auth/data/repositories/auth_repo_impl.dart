// ignore_for_file: avoid_dynamic_calls, avoid_catches_without_on_clauses

import 'package:curai_app_mobile/features/auth/data/datasources/remote_data_source.dart';
import 'package:curai_app_mobile/features/auth/data/models/register_model/register_request.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl({required this.remoteDataSource});
  final RemoteDataSource remoteDataSource;

  @override
  Future<Either<String, String>> register(
    RegisterRequest registerRequest,
  ) async {
    final response = await remoteDataSource.register(registerRequest);

    return response.fold(
      (failure) => left(failure.message),
      (result) => right(result['message'] as String),
    );
  }
}
