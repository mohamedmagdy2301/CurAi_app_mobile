import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctors_model.dart';
import 'package:curai_app_mobile/features/home/data/datasources/home_local_data_source.dart';
import 'package:curai_app_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  @override
  Future<Either<String, List<DoctorInfoModel>>> getPopularDoctor() async {
    final cachedDoctors = localDataSource.getCachedPopularDoctors();

    if (cachedDoctors.isNotEmpty) {
      return right(cachedDoctors);
    }

    final response = await remoteDataSource.getPopularDoctor();

    return response.fold(
      (failure) => left(failure.message),
      (responseData) {
        try {
          final doctors = DoctorsModel.fromJson(responseData).results ?? [];
          localDataSource.cachePopularDoctors(doctors);
          return right(doctors);
        } on Exception catch (e) {
          return left('Error parsing response: $e');
        }
      },
    );
  }

  @override
  Future<Either<String, List<DoctorInfoModel>>> getTopDoctor() async {
    final cachedDoctors = localDataSource.getCachedTopDoctors();

    if (cachedDoctors.isNotEmpty) {
      return right(cachedDoctors);
    }

    final response = await remoteDataSource.getTopDoctor();

    return response.fold(
      (failure) => left(failure.message),
      (responseData) {
        try {
          final doctors = DoctorsModel.fromJson(responseData).results ?? [];
          localDataSource.cacheTopDoctors(doctors);
          return right(doctors);
        } on Exception catch (e) {
          return left('Error parsing response: $e');
        }
      },
    );
  }

  @override
  Future<Either<String, List<SpecializationsModel>>>
      getSpecializations() async {
    final cachedSpecializations = localDataSource.getCachedSpecializations();

    if (cachedSpecializations.isNotEmpty) {
      return right(cachedSpecializations);
    }

    final response = await remoteDataSource.getSpecializations();

    return response.fold(
      (failure) {
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
        localDataSource.cacheSpecializations(specializationsList);
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
}
