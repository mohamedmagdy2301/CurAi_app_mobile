import 'dart:io';

import 'package:curai_app_mobile/features/auth/data/models/profile/profile_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_request.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class EditProfileUsecase {
  EditProfileUsecase({required this.repository});

  final AuthRepo repository;
  Future<Either<String, ProfileModel>> call(
    ProfileRequest params,
    File? imageFile,
  ) async {
    return repository.editProfile(profileRequest: params, imageFile: imageFile);
  }
}
