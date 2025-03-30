class ChangePasswordRequest {
  ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  Map<String, dynamic> toJson() => {
        'old_password': currentPassword,
        'password': newPassword,
        'password_confirm': confirmNewPassword,
      };
}
