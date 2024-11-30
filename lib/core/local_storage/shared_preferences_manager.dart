// ignore_for_file: inference_failure_on_untyped_parameter, type_annotate_public_apis

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static late SharedPreferences _sharedPreferences;
  static Future<void> sharedPreferencesInitialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({required String key, required value}) async {
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

  ///Below method is to get the boolean value from the SharedPreferences.  ///Below method is to get the boolean value from the _sharedPreferences.
  static bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  ///Below method is to get the string value from the _sharedPreferences.
  static String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  ///Below method is to set the double value from the _sharedPreferences.
  static double? getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  ///Below method is to get the int value from the _sharedPreferences.
  static int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  static Future<bool> removeData({required String key}) async {
    await _sharedPreferences.remove(key);
    return true;
  }

  static Future<bool> clearAllData() async {
    await _sharedPreferences.clear();
    return true;
  }

  ///Below method is to check the availability of the received preference .
  static bool containPreference(String key) {
    if (_sharedPreferences.get(key) == null) {
      return false;
    } else {
      return true;
    }
  }
}
