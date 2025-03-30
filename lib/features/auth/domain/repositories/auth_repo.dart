// ignore_for_file: one_member_abstracts, document_ignores

import 'dart:io';

import 'package:curai_app_mobile/features/auth/data/models/change_password/change_password_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/register/register_request.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<String, String>> register({
    required RegisterRequest registerRequest,
  });
  Future<Either<String, LoginModel>> login({
    required LoginRequest loginRequest,
  });
  Future<Either<String, String>> changePassword({
    required ChangePasswordRequest changePasswordRequest,
  });
  Future<Either<String, ProfileModel>> getProfile();
  Future<Either<String, ProfileModel>> editProfile({
    required ProfileRequest profileRequest,
    File? imageFile,
  });
  Future<Either<String, ProfileModel>> editPhotoProfile({
    File? imageFile,
  });
  Future<Either<String, String>> logout();
}
