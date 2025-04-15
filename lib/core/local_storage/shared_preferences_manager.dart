// ignore_for_file: avoid_catches_without_on_clauses

import 'package:curai_app_mobile/core/utils/helper/logger_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheDataHelper {
  static late SharedPreferences _sharedPreferences;
  static late FlutterSecureStorage _storageSecure;

  Future<void> sharedPreferencesInitialize() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      _storageSecure = const FlutterSecureStorage();
    } catch (e) {
      if (kDebugMode) {
        LoggerHelper.error('Error while initializing SharedPreferences: $e');
      }
    }
  }

  /// Save data [value] to shared preferences with [key]
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
      return true;
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
      return true;
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
      return true;
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
      return true;
    } else if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
      return true;
    }
    return false;
  }

  /// Get data from shared preferences with [key]
  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  /// Remove data from shared preferences with [key]
  static Future<bool> removeData({required String key}) async {
    await _sharedPreferences.remove(key);
    return true;
  }

  /// Clear all data from shared preferences
  static Future<bool> clearAllData() async {
    await _sharedPreferences.clear();
    return true;
  }

  /// Save data [value] to secure storage with [key]
  static Future<void> saveSecureData({
    required String key,
    required String value,
  }) async {
    await _storageSecure.write(key: key, value: value);
  }

  /// Get data from secure storage with [key]
  static Future<String> getSecureData({required String key}) async {
    return await _storageSecure.read(key: key) ?? '';
  }

  /// Remove data from secure storage with [key]
  static Future<void> removeSecureData({required String key}) async {
    await _storageSecure.delete(key: key);
  }

  /// Clear all data from secure storage
  static Future<void> clearAllSecureData() async {
    await _storageSecure.deleteAll();
  }
}
