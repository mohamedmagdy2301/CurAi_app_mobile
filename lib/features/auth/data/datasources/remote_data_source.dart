import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/error/failure.dart';
import 'package:curai_app_mobile/features/auth/data/models/register_model/register_request.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> register(
    RegisterRequest registerRequest,
  );
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> register(
    RegisterRequest registerRequest,
  ) async {
    final response = await dioConsumer.post(
      EndPoints.register,
      body: registerRequest.toJson(),
    );
    return response.fold(
      left,
      right,
    );
  }
}
