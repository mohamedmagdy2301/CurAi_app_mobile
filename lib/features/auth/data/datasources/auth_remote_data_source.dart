import 'dart:io';

import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:curai_app_mobile/core/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/features/auth/data/models/change_password/change_password_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/complete_profile/complete_profile_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/contact_us/contact_us_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/register/register_request.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> register({
    required RegisterRequest registerRequest,
  });
  Future<Either<Failure, Map<String, dynamic>>> login({
    required LoginRequest loginRequest,
  });
  Future<Either<Failure, Map<String, dynamic>>> changePassword({
    required ChangePasswordRequest changePasswordRequest,
  });
  Future<Either<Failure, Map<String, dynamic>>> getProfile();
  Future<Either<Failure, Map<String, dynamic>>> editProfile({
    required ProfileRequest profileRequest,
    // File? imageFile,
  });
  Future<Either<Failure, Map<String, dynamic>>> editPhotoProfile({
    File? imageFile,
  });
  Future<Either<Failure, Map<String, dynamic>>> logout();

  Future<Either<Failure, Map<String, dynamic>>> contactUS({
    required ContactUsRequest contactUsRequest,
  });

  Future<Either<Failure, Map<String, dynamic>>> completeProfile({
    required CompleteProfileRequest completeProfileRequest,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> register({
    required RegisterRequest registerRequest,
  }) async {
    final response = await dioConsumer.post(
      EndPoints.register,
      body: registerRequest.toJson(),
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> login({
    required LoginRequest loginRequest,
  }) async {
    final response = await dioConsumer.post(
      EndPoints.login,
      body: loginRequest.toJson(),
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> logout() async {
    final response = await dioConsumer.post(
      EndPoints.logout,
      body: {
        'refresh': getRefreshToken(),
      },
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> changePassword({
    required ChangePasswordRequest changePasswordRequest,
  }) async {
    final response = await dioConsumer.post(
      EndPoints.changePassword,
      body: changePasswordRequest.toJson(),
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProfile() async {
    final response = await dioConsumer.get(
      EndPoints.getProfile,
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> editProfile({
    required ProfileRequest profileRequest,
    // File? im ageFile,
  }) async {
    // MultipartFile? photoFile;
    // var photoName = '';

    // if (imageFile != null) {
    //   photoName = imageFile.path.split('/').last;
    //   photoFile = await MultipartFile.fromFile(
    //     imageFile.path,
    //     filename: photoName,
    //   );
    // }
    // final data = FormData.fromMap({
    //   'first_name': profileRequest.fullName,
    //   'username': profileRequest.username,
    //   'phone_number': profileRequest.phoneNumber,
    //   'location': profileRequest.location,
    //   'age': profileRequest.age,
    //   'gender': profileRequest.gender,
    //   'specialization': profileRequest.specialization,
    //   'consultation_price': profileRequest.consultationPrice,
    //   // 'profile_picture': photoFile,
    // });
    final response = await dioConsumer.patch(
      EndPoints.getProfile,
      body: profileRequest.toJson(),
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> editPhotoProfile({
    File? imageFile,
  }) async {
    MultipartFile? photoFile;
    var photoName = '';

    if (imageFile != null) {
      photoName = imageFile.path.split('/').last;
      photoFile = await MultipartFile.fromFile(
        imageFile.path,
        filename: photoName,
      );
    }
    final data = FormData.fromMap({
      'profile_picture': photoFile,
    });
    final response = await dioConsumer.patch(
      EndPoints.getProfile,
      body: data,
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> contactUS({
    required ContactUsRequest contactUsRequest,
  }) async {
    final response = await dioConsumer.post(
      EndPoints.contactUs,
      body: contactUsRequest.toJson(),
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> completeProfile({
    required CompleteProfileRequest completeProfileRequest,
  }) async {
    MultipartFile? photoFile;
    var photoName = '';

    if (completeProfileRequest.imageFile != null) {
      photoName = completeProfileRequest.imageFile!.path.split('/').last;
      photoFile = await MultipartFile.fromFile(
        completeProfileRequest.imageFile!.path,
        filename: photoName,
      );
    }
    final data = FormData.fromMap({
      'profile_picture': photoFile,
      'first_name': completeProfileRequest.firstName,
      'last_name': completeProfileRequest.lastName,
      'phone_number': completeProfileRequest.phoneNumber,
      'gender': completeProfileRequest.gender,
      'age': completeProfileRequest.age,
      'specialization': completeProfileRequest.specialization,
      'consultation_price': completeProfileRequest.consultationPrice,
      'location': completeProfileRequest.location,
      'bio': completeProfileRequest.bio,
      'latitude': completeProfileRequest.latitude,
      'longitude': completeProfileRequest.longitude,
      'role': completeProfileRequest.role,
    });
    final response = await dioConsumer.patch(
      EndPoints.getProfile,
      body: data,
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }
}
