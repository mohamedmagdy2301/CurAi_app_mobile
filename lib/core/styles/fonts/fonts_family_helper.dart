import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';

class FontsFamilyHelper {
  static const String cairoAr = 'Cairo';
  static const String poppinsEn = 'Poppins';
  static String getLocaledFontFamily() {
    if (isArabic()) {
      return cairoAr;
    } else {
      return poppinsEn;
    }
  }
}
