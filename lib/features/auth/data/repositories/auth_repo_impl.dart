// ignore_for_file: avoid_dynamic_calls,// avoid_catches_without_on_clauses, document_ignores

import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:curai_app_mobile/features/auth/data/models/change_password/change_password_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/contact_us/contact_us_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/register/register_request.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl({required this.remoteDataSource});
  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, String>> register({
    required RegisterRequest registerRequest,
  }) async {
    final response =
        await remoteDataSource.register(registerRequest: registerRequest);

    return response.fold(
      (failure) => left(failure.message),
      (result) async {
        await Future.wait([
          di.sl<CacheDataManager>().setData(
                key: SharedPrefKey.keyAccessToken,
                value: result['access'],
              ),
          di.sl<CacheDataManager>().setData(
                key: SharedPrefKey.keyRefreshToken,
                value: result['refresh'],
              ),
        ]);

        return right(result['message'] as String);
      },
    );
  }

  @override
  Future<Either<String, LoginModel>> login({
    required LoginRequest loginRequest,
  }) async {
    final response = await remoteDataSource.login(loginRequest: loginRequest);

    return response.fold(
      (failure) => left(failure.message),
      (result) async {
        await clearUserData();
        final data = LoginModel.fromJson(result);
        saveDataUser(data: data);
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

  @override
  Future<Either<String, ProfileModel>> editProfile({
    required ProfileRequest request,
  }) async {
    final response = await remoteDataSource.editProfile(
      request: request,
    );

    return response.fold(
      (failure) => left(failure.message),
      (result) => right(ProfileModel.fromJson(result)),
    );
  }

  @override
  Future<Either<String, String>> contactUs({
    required ContactUsRequest contactUsRequest,
  }) async {
    final response =
        await remoteDataSource.contactUS(contactUsRequest: contactUsRequest);

    return response.fold(
      (failure) => left(failure.message),
      (result) => right(result['message'] as String),
    );
  }
}
