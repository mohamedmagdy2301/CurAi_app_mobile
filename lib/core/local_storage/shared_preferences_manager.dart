import 'package:curai_app_mobile/core/utils/helper/logger_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheDataHelper {
  static late SharedPreferences _sharedPreferences;
  Future<void> sharedPreferencesInitialize() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
    } on Exception catch (e) {
      if (kDebugMode) {
        LoggerHelper.error('Error while initializing SharedPreferences: $e');
      }
    }
  }

  static Set<String> getKeys() => _sharedPreferences.getKeys();

  static Future<bool> setData({
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

  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    await _sharedPreferences.remove(key);
    return true;
  }

  static Future<bool> clearAllData() async {
    await _sharedPreferences.clear();
    return true;
  }
}
