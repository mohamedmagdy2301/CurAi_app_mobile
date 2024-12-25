import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';

String convertToArabicNumerals(double rating) {
  final arabicNumerals = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
  };

  final ratingString =
      rating.toStringAsFixed(1); // To ensure it has one decimal place
  return ratingString.split('').map((char) {
    return arabicNumerals[char] ?? char; // Replace digits with Arabic numerals
  }).join();
}

List<DoctorModel> doctorsList = [
  DoctorModel(
    nameAr: 'د. محمد  مجدي',
    nameEn: 'Dr. Mohamed Magdy',
    specialty: LangKeys.general,
    imageUrl: 'assets/images/mego.jpg',
    ratingAr: convertToArabicNumerals(4), // Arabic rating
    ratingEn: '4.0', // English rating
    locationAr: 'القاهرة - مدينة نصر',
    locationEn: 'Cairo - Nasr City',
    dateAr: '١٠:٣٠ صباحًا - ١٢:٠٠ مساءً',
    dateEn: '10:30 AM - 12:00 PM',
  ),
  DoctorModel(
    nameAr: 'د. هبة محمد ',
    nameEn: 'Dr. Heba Mohamed',
    specialty: LangKeys.cardiologist,
    imageUrl: 'assets/images/onboarding-doctor-1.png',
    ratingAr: convertToArabicNumerals(4), // Arabic rating
    ratingEn: '4.0', // English rating
    locationAr: 'الإسكندرية - سموحة',
    locationEn: 'Alexandria - Smouha',
    dateAr: '١٠:٣٠ صباحًا - ١٢:٠٠ مساءً',
    dateEn: '10:30 AM - 12:00 PM',
  ),
  DoctorModel(
    nameAr: 'د. أحمد علي',
    nameEn: 'Dr. Ahmed Ali',
    specialty: LangKeys.ent,
    imageUrl: 'assets/images/onboarding-doctor-2.png',
    ratingAr: convertToArabicNumerals(4.5), // Arabic rating
    ratingEn: '4.5', // English rating
    locationAr: 'المنصورة - بجوار الجامعة',
    locationEn: 'Mansoura - Near the University',
    dateAr: '١٠:٣٠ صباحًا - ١٢:٠٠ مساءً',
    dateEn: '10:30 AM - 12:00 PM',
  ),
  DoctorModel(
    nameAr: 'د. محمد عبد الله',
    nameEn: 'Dr. Mohamed Abdullah',
    specialty: LangKeys.ent,
    imageUrl: 'assets/images/mego2.jpg',
    ratingAr: convertToArabicNumerals(4.2), // Arabic rating
    ratingEn: '4.2', // English rating
    locationAr: 'المنصورة - بجوار الجامعة',
    locationEn: 'Mansoura - Near the University',
    dateAr: '١٠:٣٠ صباحًا - ١٢:٠٠ مساءً',
    dateEn: '10:30 AM - 12:00 PM',
  ),
  DoctorModel(
    nameAr: 'د. سارة جونسون',
    nameEn: 'Sarah Johnson',
    specialty: LangKeys.urologist,
    imageUrl: 'assets/images/onboarding-doctor-3.png',
    ratingAr: convertToArabicNumerals(4.8), // Arabic rating
    ratingEn: '4.8', // English rating
    locationAr: 'القاهرة - الزمالك',
    locationEn: 'Cairo - Zamalek',
    dateAr: '١٠:٣٠ صباحًا - ١٢:٠٠ مساءً',
    dateEn: '10:30 AM - 12:00 PM',
  ),
  DoctorModel(
    nameAr: 'د. محمد عبد الله',
    nameEn: 'Dr. Mohamed Abdullah',
    specialty: LangKeys.pediatric,
    imageUrl: 'assets/images/onboarding-doctor-4.png',
    ratingAr: convertToArabicNumerals(4.8), // Arabic rating
    ratingEn: '4.8', // English rating
    locationAr: 'الإسكندرية - محطة الرمل',
    locationEn: 'Alexandria - Raml Station',
    dateAr: '١٠:٣٠ صباحًا - ١٢:٠٠ مساءً',
    dateEn: '10:30 AM - 12:00 PM',
  ),
];
