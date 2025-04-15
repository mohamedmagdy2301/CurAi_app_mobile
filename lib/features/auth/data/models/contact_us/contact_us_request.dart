class ContactUsRequest {
  ContactUsRequest({
    required this.email,
    required this.message,
    required this.name,
    required this.subject,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'message': message,
        'name': name,
        'subject': subject,
      };

  final String email;
  final String message;
  final String subject;
  final String name;
}
