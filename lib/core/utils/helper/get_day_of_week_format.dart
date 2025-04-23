String getDayOfWeekFormat({required String day, required bool isArabic}) {
  if (day.toLowerCase() == 'Saturday'.toLowerCase()) {
    return isArabic ? 'السبت' : 'Saturday';
  } else if (day.toLowerCase() == 'Sunday'.toLowerCase()) {
    return isArabic ? 'الأحد' : 'Sunday';
  } else if (day.toLowerCase() == 'Monday'.toLowerCase()) {
    return isArabic ? 'الإثنين' : 'Monday';
  } else if (day.toLowerCase() == 'Tuesday'.toLowerCase()) {
    return isArabic ? 'الثلاثاء' : 'Tuesday';
  } else if (day.toLowerCase() == 'Wednesday'.toLowerCase()) {
    return isArabic ? 'الأربعاء' : 'Wednesday';
  } else if (day.toLowerCase() == 'Thursday'.toLowerCase()) {
    return isArabic ? 'الخميس' : 'Thursday';
  } else if (day.toLowerCase() == 'Friday'.toLowerCase()) {
    return isArabic ? 'الجمعة' : 'Friday';
  } else {
    return day;
  }
}
