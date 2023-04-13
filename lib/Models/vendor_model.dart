class VendorModel {
  String name;
  String shopName;
  String email;
  String password;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;

  VendorModel({
    required this.name,
    required this.shopName,
    required this.password,
    required this.email,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
  });

  // from map
  factory VendorModel.fromMap(Map<String, dynamic> map) {
    return VendorModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      shopName: map['shopName'] ?? '',
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
      "shopName": shopName,
      "createdAt": createdAt,
    };
  }
}
