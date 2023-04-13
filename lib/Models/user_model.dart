class UserModel {
  String name;
  String email;
  String password;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String securityPIN;
  String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.securityPIN,
    required this.uid,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      securityPIN: map['securityPIN'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "password": password,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "securityPIN": securityPIN,
      "createdAt": createdAt,
    };
  }
}
