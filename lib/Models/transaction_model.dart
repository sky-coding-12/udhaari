class TransactionModel {
  int? transactionId;
  int? userId;
  int? vendorId;
  String? status;
  String? paymentStatus;
  String? creditDebitStatus;
  int? amount;
  String? dueDate;
  String? transactionDate;

  TransactionModel(
      {this.transactionId,
      this.userId,
      this.vendorId,
      this.status,
      this.paymentStatus,
      this.creditDebitStatus,
      this.amount,
      this.dueDate,
      this.transactionDate});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    userId = json['userId'];
    vendorId = json['vendorId'];
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    creditDebitStatus = json['creditDebitStatus'];
    amount = json['amount'];
    dueDate = json['dueDate'];
    transactionDate = json['transactionDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.transactionId;
    data['userId'] = this.userId;
    data['vendorId'] = this.vendorId;
    data['status'] = this.status;
    data['paymentStatus'] = this.paymentStatus;
    data['creditDebitStatus'] = this.creditDebitStatus;
    data['amount'] = this.amount;
    data['dueDate'] = this.dueDate;
    data['transactionDate'] = this.transactionDate;
    return data;
  }
}
