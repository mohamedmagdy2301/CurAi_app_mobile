class DiagnosisRequest {
  DiagnosisRequest({
    required this.input,
  });

  Map<String, dynamic> toJson() => {
        'input': input,
      };

  final String input;
}
