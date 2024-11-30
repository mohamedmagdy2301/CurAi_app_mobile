import 'package:smartcare_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:smartcare_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:smartcare_app_mobile/core/utils/constants.dart';

class FontsFamilyHelper {
  static const String cairoAr = 'Cairo';
  static const String poppinsEn = 'Poppins';
  static String getLocaledFontFamily() {
    final currentLanguage =
        SharedPrefManager.getString(SharedPrefKey.language) ?? kDefaultLanguage;
    if (currentLanguage == 'ar') {
      return cairoAr;
    } else {
      return poppinsEn;
    }
  }
}
