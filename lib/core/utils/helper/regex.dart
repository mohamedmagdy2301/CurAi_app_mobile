bool isArabicFormat(String text) {
  if (text.isEmpty) return false;
  // Check if the average character is Arabic
  final arabicCharCount = text.runes.where((rune) {
    final character = String.fromCharCode(rune);
    return RegExp(r'[\u0600-\u06FF]').hasMatch(character);
  }).length;
  final englishCharCount = text.runes.where((rune) {
    final character = String.fromCharCode(rune);
    return RegExp('[a-zA-Z]').hasMatch(character);
  }).length;
  return arabicCharCount > englishCharCount;
}
