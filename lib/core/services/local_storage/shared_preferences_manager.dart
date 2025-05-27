import 'package:curai_app_mobile/core/utils/helper/logger_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheDataManager {
  ///Factory constructor to return the singleton instance of [CacheDataManager].
  factory CacheDataManager() => _instance;
  CacheDataManager._();

  /// Singleton instance of [CacheDataManager].
  static final CacheDataManager _instance = CacheDataManager._();

  late SharedPreferences _sharedPreferences;

  Future<void> sharedPreferencesInitialize() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
    } on Exception catch (e) {
      if (kDebugMode) {
        LoggerHelper.error('Error while initializing SharedPreferences: $e');
      }
    }
  }

  Set<String> getKeys() => _sharedPreferences.getKeys();

  Future<bool> setData({
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

  dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  Future<bool> removeData({required String key}) async {
    await _sharedPreferences.remove(key);
    return true;
  }

  Future<bool> clearAllData() async {
    await _sharedPreferences.clear();
    return true;
  }
}
