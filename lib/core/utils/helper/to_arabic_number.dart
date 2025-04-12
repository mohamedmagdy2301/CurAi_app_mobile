String toArabicNumber(String number) {
  switch (number) {
    case '0':
      return '٠';
    case '1':
      return '١';
    case '2':
      return '٢';
    case '3':
      return '٣';
    case '4':
      return '٤';
    case '5':
      return '٥';
    case '6':
      return '٦';
    case '7':
      return '٧';
    case '8':
      return '٨';
    case '9':
      return '٩';
    default:
      return number;
  }
}
