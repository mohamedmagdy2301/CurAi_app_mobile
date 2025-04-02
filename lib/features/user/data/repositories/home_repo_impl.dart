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
  Future<Either<String, Map<String, dynamic>>> getAllDoctor({
    int page = 1,
    String? querey,
  }) async {
    final response = await remoteDataSource.getAllDoctor(page, querey: querey);

    return response.fold((failure) {
      log(failure.message);
      return left(failure.message);
    }, (responseData) {
      return right(responseData as Map<String, dynamic>);
      ;
    });
  }
}
