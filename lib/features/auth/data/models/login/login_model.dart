class LoginModel {
  LoginModel({
    required this.role,
    required this.username,
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
    this.firstName,
    this.lastName,
    this.bonusPoints,
    this.profilePicture,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accessToken: json['access'] as String,
        refreshToken: json['refresh'] as String,
        userId: json['user_id'] as int,
        username: json['username'] as String,
        role: json['role'] as String,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        bonusPoints: json['bonus_points'] as int?,
        profilePicture: json['profile_picture'] as String?,
      );

  final String accessToken;
  final String refreshToken;
  final int userId;
  final String username;
  final String role;
  final String? firstName;
  final String? lastName;
  final int? bonusPoints;
  final String? profilePicture;
}
