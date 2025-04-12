String detectLanguage(String text) {
  var arabicCount = 0;
  var englishCount = 0;

  for (var i = 0; i < text.length; i++) {
    final codeUnit = text.codeUnitAt(i);

    // Arabic Unicode ranges
    if ((codeUnit >= 0x0600 && codeUnit <= 0x06FF) || // Arabic
        (codeUnit >= 0x0750 && codeUnit <= 0x077F)) {
      // Arabic Supplement
      arabicCount++;
    }

    // English letters (uppercase and lowercase)
    else if ((codeUnit >= 65 && codeUnit <= 90) ||
        (codeUnit >= 97 && codeUnit <= 122)) {
      englishCount++;
    }
  }

  if (arabicCount > englishCount) {
    return 'ar';
  }
  return 'en';
}
