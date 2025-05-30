import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/diagnosis_model/diagnosis_model.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/diagnosis_model/diagnosis_request.dart';
import 'package:curai_app_mobile/features/chatbot/domain/repositories/chatbot_repo.dart';
import 'package:dartz/dartz.dart';

class DiagnosisUsecase
    extends UseCase<Either<String, DiagnosisModel>, DiagnosisRequest> {
  DiagnosisUsecase({required this.repository});

  final ChatbotRepo repository;
  @override
  Future<Either<String, DiagnosisModel>> call(DiagnosisRequest params) async {
    return repository.diagnosis(diagnosisRequest: params);
  }
}
