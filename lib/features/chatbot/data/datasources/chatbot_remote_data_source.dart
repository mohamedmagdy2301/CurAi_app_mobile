import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/diagnosis_model/diagnosis_request.dart';
import 'package:dartz/dartz.dart';

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
      'https://76f1-156-199-179-208.ngrok-free.app${EndPoints.predict}',
      body: diagnosisRequest.toJson(),
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }
}
