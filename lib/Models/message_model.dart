class Message {
  int? timeRequestId;
  int? userId;
  int? transactionId;
  int? vendorId;
  String? status;
  String? message;
  String? newDate;

  Message(
      {this.timeRequestId,
      this.userId,
      this.transactionId,
      this.vendorId,
      this.status,
      this.message,
      this.newDate});

  Message.fromJson(Map<String, dynamic> json) {
    timeRequestId = json['timeRequestId'];
    userId = json['userId'];
    transactionId = json['transactionId'];
    vendorId = json['vendorId'];
    status = json['status'];
    message = json['message'];
    newDate = json['newDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeRequestId'] = this.timeRequestId;
    data['userId'] = this.userId;
    data['transactionId'] = this.transactionId;
    data['vendorId'] = this.vendorId;
    data['status'] = this.status;
    data['message'] = this.message;
    data['newDate'] = this.newDate;
    return data;
  }
}
