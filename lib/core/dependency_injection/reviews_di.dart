import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/reviews/data/datasources/reviews_remote_data_source.dart';
import 'package:curai_app_mobile/features/reviews/data/repositories/reviews_repo_impl.dart';
import 'package:curai_app_mobile/features/reviews/domain/repositories/reviews_repo.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/add_review_usecase.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/delete_review_usecase.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/get_reviews_usecase.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/update_review_usecase.dart';
import 'package:curai_app_mobile/features/reviews/presentation/cubit/reviews_cubit.dart';

void setupReviewsDI() {
  //! Cubit
  sl
    ..registerFactory<ReviewsCubit>(
      () => ReviewsCubit(
        sl<AddReviewUsecase>(),
        sl<GetReviewsUsecase>(),
        sl<UpdateReviewUsecase>(),
        sl<DeleteReviewUsecase>(),
      ),
    )

    //! Usecase
    ..registerLazySingleton<AddReviewUsecase>(
      () => AddReviewUsecase(repository: sl()),
    )
    ..registerLazySingleton<GetReviewsUsecase>(
      () => GetReviewsUsecase(repository: sl()),
    )
    ..registerLazySingleton<DeleteReviewUsecase>(
      () => DeleteReviewUsecase(repository: sl()),
    )
    ..registerLazySingleton<UpdateReviewUsecase>(
      () => UpdateReviewUsecase(repository: sl()),
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
