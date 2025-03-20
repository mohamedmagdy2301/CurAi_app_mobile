import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/error/failure.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/register_model/register_request.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> register(
    RegisterRequest registerRequest,
  );
  Future<Either<Failure, LoginModel>> login(
    LoginRequest loginRequest,
  );
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> register(
    RegisterRequest registerRequest,
  ) async {
    final response = await dioConsumer.post(
      EndPoints.register,
      body: registerRequest.toJson(),
    );
    return response.fold(
      left,
      right,
    );
  }

  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest) async {
    final response = await dioConsumer.post(
      EndPoints.login,
      body: loginRequest.toJson(),
    );
    return response.fold(
      left,
      (response) => right(LoginModel.fromJson(response)),
    );
  }
}
