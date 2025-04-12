class AddReviewRequest {
  AddReviewRequest({
    required this.doctor,
    required this.rating,
    required this.comment,
  });
  final int doctor;
  final int rating;
  final String comment;

  Map<String, dynamic> toJson() => {
        'doctor': doctor,
        'rating': rating,
        'comment': comment,
      };
}
