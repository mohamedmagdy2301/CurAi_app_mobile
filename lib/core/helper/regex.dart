bool isArabicFormat(String text) {
  if (text.isEmpty) return false;
  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
  return arabicRegex.hasMatch(text[0]);
}
