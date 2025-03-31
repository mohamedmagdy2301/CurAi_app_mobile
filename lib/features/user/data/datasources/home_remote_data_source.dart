import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getAllDoctor(
    int page, {
    String? querey,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getAllDoctor(
    int page, {
    String? querey,
  }) async {
    final response = await dioConsumer.get(
      EndPoints.getAllDoctor,
      queryParameters: {'page': page, 'search': querey},
    );

    return response.fold(left, right);
  }
}
