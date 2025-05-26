class DiagnosisModel {
  DiagnosisModel({
    this.code,
    this.inputType,
    this.messageAr,
    this.messageEn,
    this.prediction,
    this.status,
    this.time,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) => DiagnosisModel(
        code: json['code'] as int?,
        inputType: json['input_type'] as String?,
        messageAr: json['messageAr'] as String?,
        messageEn: json['messageEn'] as String?,
        prediction: json['prediction'] as String?,
        status: json['status'] as String?,
        time: json['time'] as String?,
      );

  final int? code;
  final String? inputType;
  final String? messageAr;
  final String? messageEn;
  final String? prediction;
  final String? status;
  final String? time;

  List<String> get diagnosisParts => (prediction?.contains(' - ') ?? false)
      ? prediction!.split(' - ')
      : [prediction ?? ''];

  String get diagnosis => diagnosisParts.first.trim();

  String get specialty => diagnosisParts.length > 1
      ? diagnosisParts.last.replaceFirst('Specialization:', '').trim()
      : 'Not specified';

  String get botResponseDiagnosisEn => '🧠 Diagnosis: $diagnosis';
  String get botResponseDiagnosisAr => '🧠 التشخيص: $diagnosis';
  String get botResponseSpecialtyEn => '🏥 Recommended Specialty: $specialty';
  String get botResponseSpecialtyAr => '🏥 التخصص الموصى به: $specialty';

  String get botResponseEn =>
      '$botResponseDiagnosisEn\n$botResponseSpecialtyEn';
  String get botResponseAr =>
      '$botResponseDiagnosisAr\n$botResponseSpecialtyAr';

  // Method to handle the response based on input type
  String responseMessage({required bool isArabic}) {
    if (inputType == 'image') {
      return isArabic ? (messageAr ?? diagnosis) : (messageEn ?? diagnosis);
    } else if (inputType == 'text') {
      return isArabic ? (messageAr ?? diagnosis) : (messageEn ?? diagnosis);
      // return isArabic ? botResponseAr : botResponseEn;
    }
    return isArabic
        ? 'لا يوجد تشخيص صحيح متاح'
        : 'No valid diagnosis available';
  }
}
