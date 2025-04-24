class PaymentAppointmentModel {
  PaymentAppointmentModel({
    required this.message,
    required this.newBonus,
  });

  factory PaymentAppointmentModel.fromJson(Map<String, dynamic> json) {
    return PaymentAppointmentModel(
      message: json['message'] as String,
      newBonus: json['new_bonus'] as int,
    );
  }
  final String message;
  final int newBonus;
} 



// {
//     "message": "Payment has been made successfully and the appointment has been confirmed ✅.",
//     "new_bonus": 10
// }