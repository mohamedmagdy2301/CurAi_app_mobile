// ignore_for_file: avoid_dynamic_calls, avoid_catches_without_on_clauses, document_ignores, lines_longer_than_80_chars

import 'package:curai_app_mobile/features/chatbot/data/datasources/chatbot_remote_data_source.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/diagnosis_model/diagnosis_model.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/diagnosis_model/diagnosis_request.dart';
import 'package:curai_app_mobile/features/chatbot/domain/repositories/chatbot_repo.dart';
import 'package:dartz/dartz.dart';

class ChatbotRepoImpl extends ChatbotRepo {
  ChatbotRepoImpl({required this.remoteDataSource});
  final ChatbotRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, DiagnosisModel>> diagnosis({
    required DiagnosisRequest diagnosisRequest,
  }) async {
    final response =
        await remoteDataSource.diagnosis(diagnosisRequest: diagnosisRequest);

    return response.fold(
      (failure) => left(failure.message),
      (result) => right(DiagnosisModel.fromJson(result)),
    );
  }
}
