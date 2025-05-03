class ProfileModel {
  ProfileModel({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.gender,
    this.age,
    this.email,
    this.role,
    this.specialization,
    this.consultationPrice,
    this.location,
    this.isApproved,
    this.profilePicture,
    this.bio,
    this.latitude,
    this.longitude,
    this.bonusPoints,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    username = json['username'] as String;
    firstName = (json['first_name'] ?? '') as String;
    lastName = (json['last_name'] ?? '') as String;
    phoneNumber = (json['phone_number'] ?? '') as String;
    gender = (json['gender'] ?? 'male') as String;
    age = (json['age'] ?? 0) as int;
    email = (json['email'] ?? '') as String;
    role = (json['role'] ?? '') as String;
    specialization = (json['specialization'] ?? 0) as int;
    consultationPrice = (json['consultation_price'] ?? '') as String;
    location = (json['location'] ?? '') as String;
    isApproved = (json['is_approved'] ?? false) as bool;
    profilePicture = (json['profile_picture'] ?? '') as String?;
    bio = (json['bio'] ?? '') as String;
    latitude = (json['latitude'] ?? 0.0) as double;
    longitude = (json['longitude'] ?? 0.0) as double;
    bonusPoints = (json['bonus_points'] ?? 0) as int;
  }

  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? gender;
  int? age;
  String? email;
  String? role;
  int? specialization;
  String? consultationPrice;
  String? location;
  bool? isApproved;
  String? profilePicture;
  String? bio;
  double? latitude;
  double? longitude;
  int? bonusPoints;
}

final Map<String, String> _governoratesMap = {
  'Cairo': 'القاهرة',
  'Giza': 'الجيزة',
  'Alexandria': 'الإسكندرية',
  'Sharqia': 'الشرقية',
  'Dakahlia': 'الدقهلية',
  'Beheira': 'البحيرة',
  'Monufia': 'المنوفية',
  'Qalyubia': 'القليوبية',
  'Gharbia': 'الغربية',
  'Kafr El Sheikh': 'كفر الشيخ',
  'Fayoum': 'الفيوم',
  'Beni Suef': 'بني سويف',
  'Minya': 'المنيا',
  'Assiut': 'أسيوط',
  'Sohag': 'سوهاج',
  'Qena': 'قنا',
  'Luxor': 'الأقصر',
  'Aswan': 'أسوان',
  'Damietta': 'دمياط',
  'Port Said': 'بورسعيد',
  'Ismailia': 'الإسماعيلية',
  'Suez': 'السويس',
  'North Sinai': 'شمال سيناء',
  'South Sinai': 'جنوب سيناء',
  'New Valley': 'الوادي الجديد',
  'Matrouh': 'مطروح',
  'Red Sea': 'البحر الأحمر',
};
