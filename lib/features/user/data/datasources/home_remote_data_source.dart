import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getAllDoctor(
    int page, {
    String? query,
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
  }) async {
    final response = await dioConsumer.get(
      EndPoints.getAllDoctor,
      queryParameters: {'page': page, 'search': query},
    );

    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
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
}
