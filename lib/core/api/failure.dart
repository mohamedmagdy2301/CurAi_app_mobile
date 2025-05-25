// ignore_for_file: avoid_dynamic_calls, document_ignores

import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:dio/dio.dart';

class Failure {
  const Failure(this.message);
  final String message;
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioException(DioException dioException) {
    final isArabic =
        di.sl<CacheDataManager>().getData(key: SharedPrefKey.keyLocale) == 'ar';

    switch (dioException.type) {
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          isArabic ? 'انتهت مهلة إرسال الطلب' : 'Send timeout',
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          isArabic ? 'انتهت مهلة استقبال البيانات' : 'Receive timeout',
        );
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          isArabic ? 'انتهت مهلة الاتصال' : 'Connection timeout',
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          isArabic ? 'تم إلغاء الطلب' : 'Request was canceled',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromBadResponse(
          dioException.response?.statusCode ?? 500,
          dioException.response?.data,
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          isArabic ? 'لا يوجد اتصال بالإنترنت' : 'No internet connection',
        );
      case DioExceptionType.unknown:
        return ServerFailure(isArabic ? 'خطأ غير متوقع' : 'Unexpected error');
      default:
        return ServerFailure(isArabic ? 'حدث خطأ ما' : 'Something went wrong');
    }
  }
  factory ServerFailure.fromBadResponse(int statusCode, dynamic error) {
    final isArabic =
        di.sl<CacheDataManager>().getData(key: SharedPrefKey.keyLocale) == 'ar';
    if (error is String) {
      error = error.replaceAll(RegExp(r'\n'), ' ');
    } else if (error is List) {
      error = error.join(', ');
    } else if (error is int) {
      error = error.toString();
    } else if (error is bool) {
      error = error.toString();
    } else if (error is double) {
      error = error.toString();
    } else if (error is Map<String, dynamic>) {
      error = error.entries.map((e) {
        if (e.value is List) {
          return e.value.join(', ').toString();
        }
        return e.value.toString();
      }).join('\n');
    } else {
      error = 'Unknown error';
    }
    switch (statusCode) {
      case 400:
        return ServerFailure(
          isArabic ? 'طلب غير صالح\n$error' : 'Bad request\n$error',
        );
      case 401:
        return ServerFailure(
          isArabic
              ? 'دخول غير مصرح به:\n$error'
              : 'Unauthorized access:\n$error',
        );
      case 403:
        return ServerFailure(
          isArabic ? 'الوصول محظور\n$error' : 'Access forbidden\n$error',
        );

      case 404:
        return ServerFailure(
          isArabic
              ? 'لم يتم العثور على أي معلومات\n$error'
              : 'No information found\n$error',
        );

      case 500:
        return ServerFailure(
          isArabic
              ? 'خطأ في الخادم الداخلي\n$error'
              : 'Internal server error\n$error',
        );

      default:
        return ServerFailure(isArabic ? 'حدث خطأ ما' : 'Something went wrong');
    }
  }
}
