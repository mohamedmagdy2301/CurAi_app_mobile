// import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
// import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
// import 'package:dio/dio.dart';

// class DioHelper {
//   static Dio? dio;

//   static void init() {
//     dio = Dio(
//       BaseOptions(
//         receiveDataWhenStatusError: true,
//         followRedirects: true,
//         validateStatus: (status) {
//           return status! < 500;
//         },
//       ),
//     );
//   }

//   static Future<Response> getData({
//     required String url,
//     Map<String, dynamic>? query,
//     Map<String, dynamic>? body,
//     String? lang,
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'lang': SharedPrefManager.getString(SharedPrefKey.keyLocale),
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };
//     return dio!.get(
//       url,
//       queryParameters: query,
//       data: body,
//     );
//   }

//   static Future<Response> getDataWithoutToken({
//     required String url,
//     Map<String, dynamic>? query,
//     String? lang,
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'lang': SharedPrefManager.getString(SharedPrefKey.keyLocale),
//       'Content-Type': 'application/json',
//     };
//     return dio!.get(url, queryParameters: query);
//   }

//   static Future<Response> postData({
//     required String url,
//     required Object data,
//     Map<String, dynamic>? query,
//     String? lang,
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'lang': SharedPrefManager.getString(SharedPrefKey.keyLocale),
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };
//     return dio!.post(
//       url,
//       queryParameters: query,
//       data: data,
//     );
//   }

//   static Future<Response> patchData({
//     required String url,
//     required Object data,
//     Map<String, dynamic>? query,
//     String? lang,
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'lang': SharedPrefManager.getString(SharedPrefKey.keyLocale),
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };
//     return dio!.patch(
//       url,
//       queryParameters: query,
//       data: data,
//     );
//   }

//   static Future<Response> deleteData({
//     required String url,
//     Map<String, dynamic>? query,
//     String? lang,
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'lang': SharedPrefManager.getString(SharedPrefKey.keyLocale),
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };
//     return dio!.delete(
//       url,
//       queryParameters: query,
//     );
//   }

//   static Future<Response> postDataWithoutToken({
//     required String url,
//     required Object data,
//     Map<String, dynamic>? query,
//     String? lang,
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'lang': SharedPrefManager.getString(SharedPrefKey.keyLocale),
//       'Authorization': token == null ? '' : 'Bearer $token',
//       'Content-Type': 'application/json',
//     };
//     return dio!.post(
//       url,
//       queryParameters: query,
//       data: data,
//     );
//   }

//   static Future<Response> putData({
//     required String url,
//     required Map<String, dynamic> data,
//     Map<String, dynamic>? query,
//     String? lang,
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'lang': SharedPrefManager.getString(SharedPrefKey.keyLocale),
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };
//     return dio!.put(
//       url,
//       queryParameters: query,
//       data: data,
//     );
//   }
// }
