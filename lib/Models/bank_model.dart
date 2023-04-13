class BankModel {
  String name;
  String address;
  String branchName;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;

  BankModel({
    required this.name,
    required this.address,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.branchName,
    required this.uid,
  });

  // from map
  factory BankModel.fromMap(Map<String, dynamic> map) {
    return BankModel(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      branchName: map['branchName'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "uid": uid,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "address": address,
      "branchName": branchName,
      "createdAt": createdAt,
    };
  }
}
