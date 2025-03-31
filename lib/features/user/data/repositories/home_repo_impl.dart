// ignore_for_file: avoid_dynamic_calls, avoid_catches_without_on_clauses

import 'dart:developer';

import 'package:curai_app_mobile/features/user/data/datasources/home_remote_data_source.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl({required this.remoteDataSource});
  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, List<DoctorModel>>> getAllDoctor({int page = 1}) async {
    final response = await remoteDataSource.getAllDoctor(page);

    return response.fold((failure) {
      log(failure.message);
      return left(failure.message);
    }, (responseData) {
      if (responseData['results'] == null) return right([]);
      final doctorList = <DoctorModel>[];
      for (final result in (responseData['results'] as Iterable)) {
        doctorList.add(DoctorModel.fromJson(result as Map<String, dynamic>));
      }

      return right(doctorList);
    });
  }
}
