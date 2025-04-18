import 'dart:developer';

import 'package:curai_app_mobile/features/user/data/datasources/home_remote_data_source.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/features/user/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl({required this.remoteDataSource});
  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, AllDoctorModel>> getAllDoctor({
    int page = 1,
    String? query,
    String? speciality,
  }) async {
    final response = await remoteDataSource.getAllDoctor(
      page,
      query: query,
      speciality: speciality,
    );
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        try {
          final allDoctorModel = AllDoctorModel.fromJson(responseData);
          return right(allDoctorModel);
        } catch (e) {
          return left('Error parsing response: $e');
        }
      },
    );
  }

  @override
  Future<Either<String, List<SpecializationsModel>>>
      getSpecializations() async {
    final response = await remoteDataSource.getSpecializations();
    return response.fold(
      (failure) {
        log(failure.message);
        return left(failure.message);
      },
      (responseData) {
        final specializationsList = <SpecializationsModel>[];
        for (var i = 0; i < responseData.length; i++) {
          specializationsList.add(
            SpecializationsModel.fromJson(
              responseData[i] as Map<String, dynamic>,
            ),
          );
        }
        return right(specializationsList);
      },
    );
  }
}
