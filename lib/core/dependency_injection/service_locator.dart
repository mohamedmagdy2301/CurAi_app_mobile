import 'package:curai_app_mobile/core/dependency_injection/appointment_doctor_di.dart';
import 'package:curai_app_mobile/core/dependency_injection/appointment_patient_di.dart';
import 'package:curai_app_mobile/core/dependency_injection/auth_di.dart';
import 'package:curai_app_mobile/core/dependency_injection/chatbot_di.dart';
import 'package:curai_app_mobile/core/dependency_injection/core_di.dart';
import 'package:curai_app_mobile/core/dependency_injection/home_di.dart';
import 'package:curai_app_mobile/core/dependency_injection/patient_history_di.dart';
import 'package:curai_app_mobile/core/dependency_injection/reviews_di.dart';
import 'package:curai_app_mobile/core/dependency_injection/search_di.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

/// This function initializes all dependency injection modules.
/// Call it in `main()` before running the app.
Future<void> initializeServiceLocator() async {
  /// Core services: Dio, SharedPreferences, Connectivity, etc.
  setupCoreDI();

  /// Auth feature dependencies
  setupAuthDI();

  /// Home feature dependencies
  setupHomeDI();

  /// Search feature dependencies
  setupSearchDI();

  /// DoctorReviews feature dependencies
  setupReviewsDI();

  /// Chatbot feature dependencies
  setupChatbotDI();

  /// appointment patient feature dependencies
  setupAppointmentPatinetDI();

  /// appointment doctor feature dependencies
  setupAppointmentDoctorDI();

  /// patient history feature dependencies
  setupPatientHistoryDI();
}
