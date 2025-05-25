// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/diagnosis_model/diagnosis_request.dart';
import 'package:dartz/dartz.dart';

String serverAddress = '';

abstract class ChatbotRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> diagnosis({
    required DiagnosisRequest diagnosisRequest,
  });
}

class ChatbotRemoteDataSourceImpl implements ChatbotRemoteDataSource {
  ChatbotRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> diagnosis({
    required DiagnosisRequest diagnosisRequest,
  }) async {
    final response = await dioConsumer.post(
      '$serverAddress${EndPoints.predict}',
      formDataIsEnabled: true,
      body: await diagnosisRequest.toJson(),
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }
}
