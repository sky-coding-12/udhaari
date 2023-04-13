class TimeRequestModel {
  int? timeRequestId;
  int? userId;
  int? vendorId;
  int? transactionId;
  String? status;
  String? message;
  String? newDate;

  TimeRequestModel(
      {this.timeRequestId,
      this.userId,
      this.vendorId,
      this.transactionId,
      this.status,
      this.message,
      this.newDate});

  TimeRequestModel.fromJson(Map<String, dynamic> json) {
    timeRequestId = json['timeRequestId'];
    userId = json['userId'];
    vendorId = json['vendorId'];
    transactionId = json['transactionId'];
    status = json['status'];
    message = json['message'];
    newDate = json['newDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeRequestId'] = this.timeRequestId;
    data['userId'] = this.userId;
    data['vendorId'] = this.vendorId;
    data['transactionId'] = this.transactionId;
    data['status'] = this.status;
    data['message'] = this.message;
    data['newDate'] = this.newDate;
    return data;
  }
}
