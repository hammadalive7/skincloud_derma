
class UserReport {
  final String uid;
  final String username;
  final String email;
  final String age;
  final String gender;
  final String ethnicity;
  final String city;
  final String region;
  final List<String> detectionResults;
  final List<String> lifeStyles;
  final List<String> skinConcerns;
  final String image;

  UserReport({
    required this.uid,
    required this.username,
    required this.email,
    required this.age,
    required this.gender,
    required this.ethnicity,
    required this.city,
    required this.image,

    required this.region,
    required this.detectionResults,
    required this.lifeStyles,
    required this.skinConcerns,
  });

  factory UserReport.fromFirestore(Map<String, dynamic> json) {
    return UserReport(
      uid: json['uid'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      age: json['age'] ?? '',
      image: json['skinConcernImage'] ?? '',
      gender: json['gender']?? '',
      ethnicity: json['ethnicity']?? '',
      city: json['city']?? '',
      region: json['region'] ?? '',
      detectionResults: List<String>.from(json['detectionResults'] ?? []),
      lifeStyles: List<String>.from(json['lifeStyles'] ?? []),
      skinConcerns: List<String>.from(json['skinConcerns'] ?? []),
    );
  }
}



