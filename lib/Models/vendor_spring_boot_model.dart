class VendorSpringBootModel {
  int? vendorId;
  String? shopName;
  String? vendorName;
  int? phoneNumber;
  String? email;
  String? address;
  String? password;
  int? totalDebit;
  int? totalLoanAmount;
  String? image;

  VendorSpringBootModel(
      {this.vendorId,
      this.shopName,
      this.vendorName,
      this.phoneNumber,
      this.email,
      this.address,
      this.password,
      this.totalDebit,
      this.totalLoanAmount,
      this.image});

  VendorSpringBootModel.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendorId'];
    shopName = json['shopName'];
    vendorName = json['vendorName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    password = json['password'];
    totalDebit = json['totalDebit'];
    totalLoanAmount = json['totalLoanAmount'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorId'] = this.vendorId;
    data['shopName'] = this.shopName;
    data['vendorName'] = this.vendorName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['password'] = this.password;
    data['totalDebit'] = this.totalDebit;
    data['totalLoanAmount'] = this.totalLoanAmount;
    data['image'] = this.image;
    return data;
  }
}
