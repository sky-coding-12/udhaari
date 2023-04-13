class UserSpringBootModel {
  int? userId;
  String? userName;
  int? phoneNumber;
  String? email;
  String? password;
  int? totalCredit;
  int? totalDebit;
  int? creditScore;
  String? securityPIN;
  String? image;

  UserSpringBootModel(
      {this.userId,
      this.userName,
      this.phoneNumber,
      this.email,
      this.password,
      this.totalCredit,
      this.totalDebit,
      this.creditScore,
      this.securityPIN,
      this.image});

  UserSpringBootModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    password = json['password'];
    totalCredit = json['totalCredit'];
    totalDebit = json['totalDebit'];
    creditScore = json['creditScore'];
    securityPIN = json['securityPIN'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['totalCredit'] = this.totalCredit;
    data['totalDebit'] = this.totalDebit;
    data['creditScore'] = this.creditScore;
    data['securityPIN'] = this.securityPIN;
    data['image'] = this.image;
    return data;
  }
}
