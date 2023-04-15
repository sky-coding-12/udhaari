class RemainderModel {
  int? reminderId;
  int? userId;
  int? vendorId;
  String? sendTime;

  RemainderModel({this.reminderId, this.userId, this.vendorId, this.sendTime});

  RemainderModel.fromJson(Map<String, dynamic> json) {
    reminderId = json['reminderId'];
    userId = json['userId'];
    vendorId = json['vendorId'];
    sendTime = json['sendTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reminderId'] = this.reminderId;
    data['userId'] = this.userId;
    data['vendorId'] = this.vendorId;
    data['sendTime'] = this.sendTime;
    return data;
  }
}
