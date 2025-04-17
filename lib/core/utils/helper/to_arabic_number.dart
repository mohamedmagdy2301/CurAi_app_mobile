String toArabicNumber(String number) {
  final arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  return number.split('').map((digit) => arabicDigits[int.parse(digit)]).join();
}
