import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/chatbot/data/datasources/chatbot_remote_data_source.dart';
import 'package:curai_app_mobile/features/chatbot/data/repositories/chatbot_repo_impl.dart';
import 'package:curai_app_mobile/features/chatbot/domain/repositories/chatbot_repo.dart';
import 'package:curai_app_mobile/features/chatbot/domain/usecases/diagnosis_usecase.dart';

void setupChatbotDI() {
  //! Cubit
  sl
    // ..registerFactory<ChatBotCubit>(
    //   () => ChatBotCubit(
    //     isArabic: false,
    //     sl<DiagnosisUsecase>(),
    //   ),
    // )

    //! Usecases
    ..registerLazySingleton(() => DiagnosisUsecase(repository: sl()))

    //! Repository
    ..registerLazySingleton<ChatbotRepo>(
      () => ChatbotRepoImpl(remoteDataSource: sl()),
    )

    //! Data Source
    ..registerLazySingleton<ChatbotRemoteDataSource>(
      () => ChatbotRemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    );
}
