import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcare_app_mobile/core/helper/logger_helper.dart';

class SharedPrefManager {
  SharedPrefManager._();
  static final SharedPrefManager instance = SharedPrefManager._();
  static const String tag = 'Shared Preferences Manager';
  static late SharedPreferences _sharedPreferences;

  Future<void> sharedPreferencesInitialize() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      LoggerHelper.info(
        'SharedPreferences initialized successfully.',
        tag: tag,
      );
    } catch (e) {
      LoggerHelper.error(
        'Error initializing SharedPreferences',
        tag: tag,
        error: e,
      );
    }
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    try {
      var result = false;
      if (value is String) {
        result = await _sharedPreferences.setString(key, value);
      }
      if (value is int) {
        result = await _sharedPreferences.setInt(key, value);
      }
      if (value is bool) {
        result = await _sharedPreferences.setBool(key, value);
      }
      if (value is double) {
        result = await _sharedPreferences.setDouble(key, value);
      }
      if (value is List<String>) {
        result = await _sharedPreferences.setStringList(key, value);
      }

      LoggerHelper.info('Data set: Key = $key, Value = $value', tag: tag);
      return result;
    } catch (e) {
      LoggerHelper.error('Error setting data for key $key', tag: tag, error: e);
      return false;
    }
  }

  static bool? getBool(String key) {
    try {
      final value = _sharedPreferences.getBool(key);
      LoggerHelper.info('Data retrieved: Key = $key, Value = $value', tag: tag);
      return value;
    } catch (e) {
      LoggerHelper.error(
        'Error retrieving boolean for key $key',
        tag: tag,
        error: e,
      );
      return null;
    }
  }

  static String? getString(String key) {
    try {
      final value = _sharedPreferences.getString(key);
      LoggerHelper.info('Data retrieved: Key = $key, Value = $value', tag: tag);
      return value;
    } catch (e) {
      LoggerHelper.error(
        'Error retrieving string for key $key',
        tag: tag,
        error: e,
      );
      return null;
    }
  }

  static double? getDouble(String key) {
    try {
      final value = _sharedPreferences.getDouble(key);
      LoggerHelper.info('Data retrieved: Key = $key, Value = $value', tag: tag);
      return value;
    } catch (e) {
      LoggerHelper.error(
        'Error retrieving double for key $key',
        tag: tag,
        error: e,
      );
      return null;
    }
  }

  static int? getInt(String key) {
    try {
      final value = _sharedPreferences.getInt(key);
      LoggerHelper.info('Data retrieved: Key = $key, Value = $value', tag: tag);
      return value;
    } catch (e) {
      LoggerHelper.error(
        'Error retrieving integer for key $key',
        tag: tag,
        error: e,
      );
      return null;
    }
  }

  static Future<bool> removeData({required String key}) async {
    try {
      final result = await _sharedPreferences.remove(key);
      LoggerHelper.info('Data removed: Key = $key', tag: tag);
      return result;
    } catch (e) {
      LoggerHelper.error(
        'Error removing data for key $key',
        tag: tag,
        error: e,
      );
      return false;
    }
  }

  static Future<bool> clearAllData() async {
    try {
      final result = await _sharedPreferences.clear();
      LoggerHelper.info('All SharedPreferences data cleared.', tag: tag);
      return result;
    } catch (e) {
      LoggerHelper.error(
        'Error clearing all SharedPreferences data',
        tag: tag,
        error: e,
      );
      return false;
    }
  }

  static bool containPreference(String key) {
    try {
      final exists = _sharedPreferences.containsKey(key);
      LoggerHelper.info(
        'Key existence check: Key = $key, Exists = $exists',
        tag: tag,
      );
      return exists;
    } catch (e) {
      LoggerHelper.error(
        'Error checking key existence: Key = $key',
        tag: tag,
        error: e,
      );
      return false;
    }
  }
}
