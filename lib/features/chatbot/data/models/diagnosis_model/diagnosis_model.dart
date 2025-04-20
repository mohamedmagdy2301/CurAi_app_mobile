class DiagnosisModel {
  DiagnosisModel({
    this.code,
    this.isMedical,
    this.message,
    this.prediction,
    this.status,
    this.time,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) => DiagnosisModel(
        code: json['code'] as int?,
        isMedical: json['is_medical'] as bool?,
        message: json['message'] as String?,
        prediction: json['prediction'] as String?,
        status: json['status'] as String?,
        time: json['time'] as String?,
      );

  final int? code;
  final bool? isMedical;
  final String? message;
  final String? prediction;
  final String? status;
  final String? time;

  List<String> get diagnosisParts => (prediction ?? '').split(' - ');

  String get diagnosis => diagnosisParts.first.trim();

  String get specialty => diagnosisParts.length > 1
      ? diagnosisParts.last.replaceFirst('Specialization:', '').trim()
      : 'Not specified';

  String get botResponseDiagnosis => '🧠 Diagnosis: $diagnosis';

  String get botResponseSpecialty => '🏥 Recommended Specialty: $specialty';

  String get botResponse => '$botResponseDiagnosis\n$botResponseSpecialty';
}
