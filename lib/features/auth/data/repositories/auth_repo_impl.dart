// ignore_for_file: avoid_dynamic_calls, avoid_catches_without_on_clauses

import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/error/failure.dart';
import 'package:curai_app_mobile/features/auth/data/models/register_model/register_request.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl(this.dioConsumer);
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, String>> register(
    RegisterRequest registerRequest,
  ) async {
    try {
      final response = await dioConsumer.post(
        EndPoints.register,
        body: registerRequest.toJson(),
      );
      return Right(response['message'].toString());
    } on FailureException catch (e) {
      return Left(e.failure);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(Failure('Unexpected error occurred: $e'));
    }
  }
}
