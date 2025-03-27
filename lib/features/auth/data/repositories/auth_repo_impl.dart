// ignore_for_file: avoid_dynamic_calls, avoid_catches_without_on_clauses

import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/features/auth/data/datasources/remote_data_source.dart';
import 'package:curai_app_mobile/features/auth/data/models/change_password/change_password_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/register/register_request.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl({required this.remoteDataSource});
  final RemoteDataSource remoteDataSource;

  @override
  Future<Either<String, String>> register({
    required RegisterRequest registerRequest,
  }) async {
    final response =
        await remoteDataSource.register(registerRequest: registerRequest);

    return response.fold(
      (failure) => left(failure.message),
      (result) => right(result['message'] as String),
    );
  }

  @override
  Future<Either<String, LoginModel>> login({
    required LoginRequest loginRequest,
  }) async {
    final response = await remoteDataSource.login(loginRequest: loginRequest);

    return response.fold(
      (failure) => left(failure.message),
      (result) {
        final data = LoginModel.fromJson(result);
        saveDataUser(
          accessToken: data.accessToken,
          refreshToken: data.refreshToken,
          role: data.role,
          userName: data.username,
          userId: data.userId,
        );
        return right(data);
      },
    );
  }

  @override
  Future<Either<String, String>> logout() async {
    final response = await remoteDataSource.logout();
    return response.fold(
      (failure) => left(failure.message),
      (result) => right(result['detail'] as String),
    );
  }

  @override
  Future<Either<String, String>> changePassword({
    required ChangePasswordRequest changePasswordRequest,
  }) async {
    final response = await remoteDataSource.changePassword(
      changePasswordRequest: changePasswordRequest,
    );

    return response.fold(
      (failure) => left(failure.message),
      (result) => right(result['detail'] as String),
    );
  }

  @override
  Future<Either<String, ProfileModel>> getProfile() async {
    final response = await remoteDataSource.getProfile();

    return response.fold(
      (failure) => left(failure.message),
      (result) => right(ProfileModel.fromJson(result)),
    );
  }
}

void saveDataUser({
  required String accessToken,
  String? refreshToken,
  String? role,
  String? userName,
  int? userId,
}) {
  CacheDataHelper.setData(
    key: SharedPrefKey.keyAccessToken,
    value: accessToken,
  );
  CacheDataHelper.setData(
    key: SharedPrefKey.keyRefreshToken,
    value: refreshToken ?? '',
  );
  CacheDataHelper.setData(
    key: SharedPrefKey.keyUserName,
    value: userName ?? '',
  );
  CacheDataHelper.setData(
    key: SharedPrefKey.keyRole,
    value: role ?? '',
  );
  CacheDataHelper.setData(
    key: SharedPrefKey.keyUserId,
    value: userId ?? '',
  );
}
