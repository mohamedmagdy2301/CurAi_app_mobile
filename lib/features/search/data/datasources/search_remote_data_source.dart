// ignore_for_file: one_member_abstracts

import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getDoctors(
    int page, {
    String? query,
    String? speciality,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  SearchRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getDoctors(
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
}
