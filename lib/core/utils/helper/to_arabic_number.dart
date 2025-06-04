String toArabicNumber(String number) {
  final arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  return number.split('').map((char) {
    final digit = int.tryParse(char);
    return digit != null ? arabicDigits[digit] : char;
  }).join();
}
