// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/features/auth/data/models/register_model/register_request.dart';

abstract class RemoteDataSource {
  Future<dynamic> register(
    RegisterRequest registerRequest,
  );
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<dynamic> register(
    RegisterRequest registerRequest,
  ) async {
    final response = await dioConsumer.post(
      EndPoints.register,
      body: registerRequest.toJson(),
    );
    return response;
  }
}
