class AddReviewRequest {
  AddReviewRequest({this.doctor, this.rating, this.comment});
  int? doctor;
  int? rating;
  String? comment;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['doctor'] = doctor;
    data['rating'] = rating;
    data['comment'] = comment;
    return data;
  }
}
