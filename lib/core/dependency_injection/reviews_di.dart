import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/reviews/data/datasources/reviews_remote_data_source.dart';
import 'package:curai_app_mobile/features/reviews/data/repositories/reviews_repo_impl.dart';
import 'package:curai_app_mobile/features/reviews/domain/repositories/reviews_repo.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/add_reviews_usecase.dart';
import 'package:curai_app_mobile/features/reviews/presentation/cubit/reviews_cubit.dart';

void setupReviewsDI() {
  //! Cubit
  sl
    ..registerFactory<ReviewsCubit>(
      () => ReviewsCubit(sl<AddReviewsUsecase>()),
    )

    //! Usecase
    ..registerLazySingleton<AddReviewsUsecase>(
      () => AddReviewsUsecase(repository: sl()),
    )

    //! Repository
    ..registerLazySingleton<ReviewsRepo>(
      () => ReviewsRepoImpl(remoteDataSource: sl()),
    )

    //! Data Source
    ..registerLazySingleton<ReviewsRemoteDataSource>(
      () => ReviewsRemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    );
}
