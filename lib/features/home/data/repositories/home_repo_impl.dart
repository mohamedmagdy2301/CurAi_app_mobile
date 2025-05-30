import 'dart:developer';

import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctors_model.dart';
import 'package:curai_app_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl({required this.remoteDataSource});
  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, List<DoctorInfoModel>>> getPopularDoctor() async {
    final response = await remoteDataSource.getPopularDoctor();
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        try {
          final allDoctorModel = DoctorsModel.fromJson(responseData);
          return right(allDoctorModel.results ?? []);
        } on Exception catch (e) {
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

  @override
  Future<Either<String, DoctorInfoModel>> getDoctorById({int? id}) async {
    final response = await remoteDataSource.getDoctorById(id: id);
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        try {
          final allDoctorModel = DoctorInfoModel.fromJson(responseData);
          return right(allDoctorModel);
        } on Exception catch (e) {
          return left('Error parsing response: $e');
        }
      },
    );
  }

  @override
  Future<Either<String, List<DoctorInfoModel>>> getTopDoctor() async {
    final response = await remoteDataSource.getTopDoctor();
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        try {
          final topDoctorModel = (responseData as List)
              .map((e) => DoctorInfoModel.fromJson(e as Map<String, dynamic>))
              .toList();

          return right(topDoctorModel);
        } on Exception catch (e) {
          return left('Error parsing response: $e');
        }
      },
    );
  }
}
