import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/features/auth/data/models/change_password/change_password_request.dart';
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
    required ProfileRequest request,
  });

  Future<Either<Failure, Map<String, dynamic>>> logout();

  Future<Either<Failure, Map<String, dynamic>>> contactUS({
    required ContactUsRequest contactUsRequest,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> register({
    required RegisterRequest registerRequest,
  }) async {
    await clearUserData();
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
    await clearUserData();
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
    required ProfileRequest request,
  }) async {
    final data = <String, dynamic>{};

    if (request.profileImage != null) {
      final photoName = request.profileImage!.path.split('/').last;
      data['profile_picture'] = await MultipartFile.fromFile(
        request.profileImage!.path,
        filename: photoName,
      );
    }
    if (request.profileCertificate != null) {
      final photoName = request.profileCertificate!.path.split('/').last;
      data['profile_certificate'] = await MultipartFile.fromFile(
        request.profileCertificate!.path,
        filename: photoName,
      );
    }

    if (request.username != null) data['username'] = request.username;
    if (request.firstName != null) data['first_name'] = request.firstName;
    if (request.lastName != null) data['last_name'] = request.lastName;
    if (request.phoneNumber != null) data['phone_number'] = request.phoneNumber;
    if (request.gender != null) data['gender'] = request.gender;
    if (request.age != null) data['age'] = request.age;
    if (request.specialization != null) {
      data['specialization'] = request.specialization;
    }
    if (request.consultationPrice != null) {
      data['consultation_price'] = request.consultationPrice;
    }
    if (request.location != null) data['location'] = request.location;
    if (request.bio != null) data['bio'] = request.bio;
    if (request.latitude != null) data['latitude'] = request.latitude;
    if (request.longitude != null) data['longitude'] = request.longitude;
    if (request.role != null) data['role'] = request.role;
    if (request.isApproved != null) data['is_approved'] = request.isApproved;

    final response = await dioConsumer.patch(
      EndPoints.getProfile,
      body: data,
      formDataIsEnabled: true,
    );

    return response.fold(left, (r) {
      if (r is Map<String, dynamic>) {
        return right(r);
      } else {
        return left(const Failure('Unexpected response format'));
      }
    });
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
}
