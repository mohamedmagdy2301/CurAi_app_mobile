class ReviewRequest {
  ReviewRequest({
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
