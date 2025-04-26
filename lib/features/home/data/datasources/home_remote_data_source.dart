import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getAllDoctor(
    int page, {
    String? query,
    String? speciality,
  });
  Future<Either<Failure, Map<String, dynamic>>> getDoctorById({
    int? id,
  });
  Future<Either<Failure, List<dynamic>>> getSpecializations();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getAllDoctor(
    int page, {
    String? query,
    String? speciality,
  }) async {
    final response = await dioConsumer.get(
      EndPoints.getAllDoctor,
      queryParameters: {
        'page': page,
        'search': query,
        'specialization': speciality,
      },
    );

    return response.fold(
      left,
      (r) {
        if (r is Map<String, dynamic>) {
          return right(r);
        }
        return left(ServerFailure('Invalid response format'));
      },
    );
  }

  @override
  Future<Either<Failure, List<dynamic>>> getSpecializations() async {
    final response = await dioConsumer.get(
      EndPoints.getSpecializations,
    );

    return response.fold(
      left,
      (data) {
        if (data is List) {
          return right(data);
        }
        return left(ServerFailure('Invalid response format'));
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getDoctorById({int? id}) async {
    final response = await dioConsumer.get(
      '${EndPoints.getAllDoctor}$id/',
    );

    return response.fold(
      left,
      (r) {
        if (r is Map<String, dynamic>) {
          return right(r);
        }
        return left(ServerFailure('Invalid response format'));
      },
    );
  }
}
