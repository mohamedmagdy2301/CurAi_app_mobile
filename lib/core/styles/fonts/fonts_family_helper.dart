class FontsFamilyHelper {
  static const String cairoAr = 'Cairo';
  static const String poppinsEn = 'Poppins';
  static String getLocaledFontFamily() {
    const currentLanguage = 'ar';
    if (currentLanguage == 'ar') {
      return cairoAr;
    } else {
      return poppinsEn;
    }
  }
}
