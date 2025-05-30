import 'package:curai_app_mobile/core/utils/models/doctor_model/doctors_model.dart';
import 'package:curai_app_mobile/features/search/data/datasources/search_remote_data_source.dart';
import 'package:curai_app_mobile/features/search/domain/repositories/search_repo.dart';
import 'package:dartz/dartz.dart';

class SearchRepoImpl extends SearchRepo {
  SearchRepoImpl({required this.remoteDataSource});
  final SearchRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, DoctorsModel>> getDoctors({
    int page = 1,
    String? query,
    String? speciality,
  }) async {
    final response = await remoteDataSource.getDoctors(
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
          final allDoctorModel = DoctorsModel.fromJson(responseData);
          return right(allDoctorModel);
        } on Exception catch (e) {
          return left('Error parsing response: $e');
        }
      },
    );
  }
}
