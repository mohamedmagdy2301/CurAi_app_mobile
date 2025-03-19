// ignore_for_file: avoid_dynamic_calls, avoid_catches_without_on_clauses

import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/error/failure.dart';
import 'package:curai_app_mobile/features/auth/data/datasources/remote_data_source.dart';
import 'package:curai_app_mobile/features/auth/data/models/register_model/register_request.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl({required this.remoteDataSource});
  final RemoteDataSource remoteDataSource;
  @override
  Future<Either<String, String>> register(
    RegisterRequest registerRequest,
  ) async {
    try {
      final result = await remoteDataSource.register(registerRequest);
      return Right(result['message'].toString());
    } on FailureException catch (e) {
      return Left(e.failure.message);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e).message);
    } catch (e) {
      return Left(Failure('Unexpected error occurred: $e').message);
    }
  }
}
