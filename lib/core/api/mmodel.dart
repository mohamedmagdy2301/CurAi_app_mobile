class TokenModel {
  TokenModel({this.access});

  TokenModel.fromJson(Map<String, dynamic> json) {
    access = (json['access'] ?? '') as String;
  }
  String? access;
}
