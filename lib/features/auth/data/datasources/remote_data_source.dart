import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/features/auth/data/models/change_password/change_password_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/register/register_request.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> register({
    required RegisterRequest registerRequest,
  });
  Future<Either<Failure, Map<String, dynamic>>> login({
    required LoginRequest loginRequest,
  });
  Future<Either<Failure, Map<String, dynamic>>> changePassword({
    required ChangePasswordRequest changePasswordRequest,
  });
  Future<Either<Failure, Map<String, dynamic>>> logout();
  Future<Either<Failure, Map<String, dynamic>>> getProfile();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> register({
    required RegisterRequest registerRequest,
  }) async {
    final response = await dioConsumer.post(
      EndPoints.register,
      body: registerRequest.toJson(),
    );
    return response.fold(left, right);
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> login({
    required LoginRequest loginRequest,
  }) async {
    final response = await dioConsumer.post(
      EndPoints.login,
      body: loginRequest.toJson(),
    );
    return response.fold(left, right);
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> logout() async {
    final response = await dioConsumer.post(
      EndPoints.logout,
      body: {
        'refresh': SharedPrefManager.getString(SharedPrefKey.keyRefreshToken),
      },
    );
    return response.fold(left, right);
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> changePassword({
    required ChangePasswordRequest changePasswordRequest,
  }) async {
    final response = await dioConsumer.post(
      EndPoints.changePassword,
      body: changePasswordRequest.toJson(),
    );
    return response.fold(left, right);
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProfile() async {
    final response = await dioConsumer.get(
      EndPoints.getProfile,
    );
    return response.fold(left, right);
  }
}
