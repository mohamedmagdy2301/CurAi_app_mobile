import 'package:curai_app_mobile/features/user/data/datasources/home_remote_data_source.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl({required this.remoteDataSource});
  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, AllDoctorModel>> getAllDoctor({
    int page = 1,
    String? query,
  }) async {
    final response = await remoteDataSource.getAllDoctor(page, query: query);
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
}
