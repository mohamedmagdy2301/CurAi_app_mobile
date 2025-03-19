import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

// import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
// import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
// import 'package:dio/dio.dart';

// class Failure {
//   const Failure(this.message);
//   final String message;
// }

// class ServerFailure extends Failure {
//   ServerFailure(super.message);

//   factory ServerFailure.fromDioException(DioException dioException) {
//     final isArabic =
//         SharedPrefManager.getString(SharedPrefKey.keyLocale) == 'ar';
//     switch (dioException.type) {
//       case DioExceptionType.sendTimeout:
//         return ServerFailure(
//           isArabic
//               ? 'انتهت مهلة إرسال الاتصال بخادم API'
//               : 'Send timeout with API server',
//         );

//       case DioExceptionType.receiveTimeout:
//         return ServerFailure(
//           isArabic
//               ? 'انتهت مهلة استقبال الاتصال بخادم API'
//               : 'Receive timeout with API server',
//         );

//       case DioExceptionType.connectionTimeout:
//         return ServerFailure(
//           isArabic
//               ? 'انتهت مهلة الاتصال بخادم API'
//               : 'Connection timeout with API server',
//         );

//       case DioExceptionType.cancel:
//         return ServerFailure(
//           isArabic
//               ? 'تم إلغاء الطلب إلى خادم API'
//               : 'Request to API server was canceled',
//         );

//       case DioExceptionType.badResponse:
//         final statusCode = dioException.response?.statusCode ?? 500;
//         final data = dioException.response?.data;
//         var errorMessage =
//             isArabic ? 'حدث خطأ في الخادم' : 'Server error occurred';

//         if (data is Map<String, dynamic> && data.containsKey('message')) {
//           errorMessage = data['message'] as String;
//         }

//         return ServerFailure.fromBadResponse(statusCode, errorMessage);

//       case DioExceptionType.badCertificate:
//         return ServerFailure(
//           isArabic ? 'شهادة غير صالحة' : 'Invalid certificate',
//         );

//       case DioExceptionType.connectionError:
//         return ServerFailure(
//           isArabic ? 'لا يوجد اتصال بالإنترنت' : 'No internet connection',
//         );

//       case DioExceptionType.unknown:
//         if (dioException.message?.contains('SocketException') ?? false) {
//           return ServerFailure(
//             isArabic ? 'لا يوجد اتصال بالإنترنت' : 'No internet connection',
//           );
//         } else {
//           return ServerFailure(
//             isArabic ? 'حدث خطأ غير متوقع' : 'Unexpected error occurred',
//           );
//         }
//     }
//   }

//   factory ServerFailure.fromBadResponse(int statusCode, dynamic response) {
//     final isArabic =
//         SharedPrefManager.getString(SharedPrefKey.keyLocale) == 'ar';

//     switch (statusCode) {
//       case 400:
//         return ServerFailure(
//           isArabic
//               ? 'طلب غير صالح، يرجى إبلاغ المطور\n$response'
//               : 'Bad request, please contact the developer\n$response',
//         );

//       case 401:
//         return ServerFailure(
//           isArabic
//               ? 'دخول غير مصرح به\n$response'
//               : 'Unauthorized access\n$response',
//         );

//       case 403:
//         return ServerFailure(
//           isArabic ? 'الوصول محظور\n$response' : 'Access forbidden\n$response',
//         );

//       case 404:
//         return ServerFailure(
//           isArabic
//               ? 'لم يتم العثور على أي معلومات\n$response'
//               : 'No information found\n$response',
//         );

//       case 409:
//         return ServerFailure(
//           isArabic
//               ? 'تعارض في الوصول\n$response'
//               : 'Conflict in access\n$response',
//         );

//       case 422:
//         return ServerFailure(
//           isArabic
//               ? 'كيان غير قابل للمعالجة\n$response'
//               : 'Unprocessable entity\n$response',
//         );

//       case 429:
//         return ServerFailure(
//           isArabic
//               ? 'طلبات كثيرة جدًا\n$response'
//               : 'Too many requests\n$response',
//         );

//       case 502:
//         return ServerFailure(
//           isArabic ? 'بوابة سيئة\n$response' : 'Bad gateway\n$response',
//         );

//       case 503:
//         return ServerFailure(
//           isArabic
//               ? 'الخدمة غير متوفرة\n$response'
//               : 'Service unavailable\n$response',
//         );

//       case 500:
//         return ServerFailure(
//           isArabic
//               ? 'خطأ في الخادم الداخلي\n$response'
//               : 'Internal server error\n$response',
//         );

//       default:
//         if (statusCode == 200 && response != null) {
//           return ServerFailure('$response');
//         }
//         return ServerFailure(isArabic ? 'حدث خطأ ما' : 'Something went wrong');
//     }
//   }
// }
