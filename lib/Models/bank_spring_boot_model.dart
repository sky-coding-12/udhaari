class BankSpringBootModel {
  int? bankId;
  String? bankName;
  String? bankAddress;
  String? bankBranch;
  String? image;
  int? phoneNumber;

  BankSpringBootModel(
      {this.bankId,
      this.bankName,
      this.bankAddress,
      this.image,
      this.bankBranch,
      this.phoneNumber});

  BankSpringBootModel.fromJson(Map<String, dynamic> json) {
    bankId = json['bankId'];
    bankName = json['bankName'];
    bankAddress = json['bankAddress'];
    bankBranch = json['bankBranch'];
    phoneNumber = json['phoneNumber'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankId'] = bankId;
    data['bankName'] = bankName;
    data['bankAddress'] = bankAddress;
    data['bankBranch'] = bankBranch;
    data['phoneNumber'] = phoneNumber;
    data['image'] = image;
    return data;
  }
}
