extension StringExtension on String {
  String get capitalizeFirstChar => split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');

  String get capitalizeWord =>
      split(' ').map((word) => word.toUpperCase()).join(' ');
}
