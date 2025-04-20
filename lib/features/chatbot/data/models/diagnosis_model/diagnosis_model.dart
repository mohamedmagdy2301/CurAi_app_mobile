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
}
