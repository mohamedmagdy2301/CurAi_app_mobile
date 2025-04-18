import 'package:curai_app_mobile/core/dependency_injection/auth_di.dart';
import 'package:curai_app_mobile/core/dependency_injection/core_di.dart';
import 'package:curai_app_mobile/core/dependency_injection/home_di.dart';
import 'package:curai_app_mobile/core/dependency_injection/reviews_di.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

/// This function initializes all dependency injection modules.
/// Call it in `main()` before running the app.
Future<void> setupAllDependencies() async {
  /// Core services: Dio, SharedPreferences, Connectivity, etc.
  setupCoreDI();

  /// Auth feature dependencies
  setupAuthDI();

  /// Home feature dependencies
  setupHomeDI();

  /// Reviews feature dependencies
  setupReviewsDI();
}
