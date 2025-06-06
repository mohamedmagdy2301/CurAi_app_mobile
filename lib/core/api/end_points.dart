class EndPoints {
  static const String refreshToken = '/api/token/refresh/';
  static const String register = '/api/register/';
  static const String login = '/api/login/';
  static const String logout = '/api/logout/';
  static const String changePassword = '/api/change-password/';
  static const String getProfile = '/api/profile/';
  static const String getAllDoctor = '/All_doctors/';
  static const String getSpecializations = '/specializations/';
  static const String addReview = '/review/';
  static String getReviews(int id) => '/doctor_reviews/$id/reviews/';
  static String updateReview(int id) => '/review/$id/';
  static const String contactUs = '/api/contact-us/';
  static const String predict = '/predict';
  static const String appointmentPatient = '/patient_panal_appointments';
  static const String getAppointmentAvailable =
      '$appointmentPatient/doctor_availability/';
  static const String simulateAppointmentPayment = '/simulate_payment/';
  static const String appointmentDoctor = '/doctor_panal_availabilities/';
  static const String getReservationsDoctor =
      '/doctor_panal_availabilities/appointments_by_day/';

  static const String getTopDoctor = '/api/top-doctors/';

  static String addHistory(int id) => '/api/patients/$id/add-history/';

  static String getHistory(int id) => '/api/patients/$id/history/';

  static const String discountPayment = '/generate-temporary-coupon/';
}
