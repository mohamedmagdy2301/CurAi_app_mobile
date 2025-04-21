// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/features/chatbot/data/models/diagnosis_model/diagnosis_model.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/diagnosis_model/diagnosis_request.dart';
import 'package:dartz/dartz.dart';

abstract class ChatbotRepo {
  Future<Either<String, DiagnosisModel>> diagnosis({
    required DiagnosisRequest diagnosisRequest,
  });
}
