class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final DateTime lastActive;
  final bool isOnline;
  final bool hasSubscribed;
  final bool isDoctor;

  const UserModel({
    required this.name,
    required this.image,
    required this.lastActive,
    required this.uid,
    required this.email,
    this.isOnline = false,
    this.hasSubscribed = false,
    this.isDoctor = true,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
        uid: json['uid'],
        name: json['name'],
        image: json['image'],
        email: json['email'],
        isOnline: json['isOnline'] ?? false,
        lastActive: json['lastActive'].toDate(),
        isDoctor: json['isDoctor'] ?? false,
        hasSubscribed: json['hasSubscribed'] ?? false,
      );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'image': image,
    'email': email,
    'isOnline': isOnline,
    'lastActive': lastActive,
    'isDoctor': isDoctor,
    'hasSubscribed': hasSubscribed,
  };
}
