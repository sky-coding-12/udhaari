import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../Constant/const_variable.dart';
import '../../../Models/time_request_model.dart';
import '../../../Models/transaction_model.dart';
import '../../../services/api_calling.dart';
import 'vendor_dashboard_user.dart';

class UpdateTimeRequest extends StatefulWidget {
  final int transactionId;
  final int requestId;
  const UpdateTimeRequest(
      {Key? key, required this.transactionId, required this.requestId})
      : super(key: key);

  @override
  State<UpdateTimeRequest> createState() => _UpdateTimeRequestState();
}

class _UpdateTimeRequestState extends State<UpdateTimeRequest> {
  late int transactionId;
  late int requestId;

  late Future<TimeRequestModel> request;
  late Future<TransactionModel> transaction;

  late int userId;
  late int vendorId;
  late String status;
  late String paymentStatus;
  late String creditDebitStatus;
  late int amount;
  late String transactionDate;

  @override
  void initState() {
    super.initState();
    transactionId = widget.transactionId;
    requestId = widget.requestId;
    setState(() {
      transaction = fetchOneTransaction(transactionId.toString());
      request = getTimeRequestById(requestId.toString());
    });
    transaction.then((value) => {
          userId = value.userId!,
          vendorId = value.vendorId!,
          status = value.status!,
          paymentStatus = value.paymentStatus!,
          creditDebitStatus = value.creditDebitStatus!,
          amount = value.amount!,
          transactionDate = value.transactionDate!,
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              CupertinoIcons.back,
              color: mainColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Update Time Requests",
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: FutureBuilder(
                future: request,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        const SizedBox(height: 15.0),
                        SizedBox(
                          height: 80.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 8.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Time RequestId : ",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: mainColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    "${snapshot.data!.timeRequestId}",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          height: 80.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 8.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Transaction Id : ",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: mainColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    "${snapshot.data!.transactionId}",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          height: 80.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 8.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Customer Phone No : ",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: mainColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    "${snapshot.data!.userId}",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          height: 80.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 8.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FutureBuilder(
                                future: transaction,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  } else if (snapshot.hasData) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Amount : ",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: mainColor,
                                          ),
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          "${snapshot.data!.amount}",
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          height: 80.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 8.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Due Date : ",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: mainColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    "${snapshot.data!.dueDate}",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          height: 80.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 8.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "New Date : ",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: mainColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    "${snapshot.data!.newDate}",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.height *
                                      0.065,
                                  child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.green)),
                                    onPressed: () {
                                      updateTimeRequest(
                                        snapshot.data!.transactionId,
                                        snapshot.data!.dueDate,
                                        snapshot.data!.newDate,
                                        snapshot.data!.userId,
                                        snapshot.data!.timeRequestId,
                                        "Approved",
                                        snapshot.data!.vendorId,
                                        snapshot.data!.message,
                                      )
                                          .then((value) => updateTransaction(
                                                transactionId,
                                                userId,
                                                value.newDate,
                                                amount,
                                                creditDebitStatus,
                                                status,
                                                transactionDate,
                                                vendorId,
                                                paymentStatus,
                                              ))
                                          .whenComplete(() => AwesomeDialog(
                                                context: context,
                                                headerAnimationLoop: true,
                                                animType: AnimType.scale,
                                                btnCancelColor: mainColor,
                                                dialogType: DialogType.success,
                                                btnOkOnPress: () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const VendorDashBoard(),
                                                    ),
                                                  );
                                                },
                                                btnOkColor: mainColor,
                                                title: 'Success',
                                                desc:
                                                    'Time Request Approved Successfully',
                                              ).show());
                                    },
                                    child: const Text(
                                      "APPROVE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Flexible(
                                flex: 1,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.height *
                                      0.065,
                                  child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.red)),
                                    onPressed: () {
                                      updateTimeRequest(
                                        snapshot.data!.transactionId,
                                        snapshot.data!.dueDate,
                                        snapshot.data!.newDate,
                                        snapshot.data!.userId,
                                        snapshot.data!.timeRequestId,
                                        "Rejected",
                                        snapshot.data!.vendorId,
                                        snapshot.data!.message,
                                      ).whenComplete(() => AwesomeDialog(
                                            context: context,
                                            headerAnimationLoop: true,
                                            animType: AnimType.scale,
                                            btnCancelColor: mainColor,
                                            dialogType: DialogType.success,
                                            btnOkOnPress: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const VendorDashBoard(),
                                                ),
                                              );
                                            },
                                            btnOkColor: mainColor,
                                            title: 'Success',
                                            desc:
                                                'Time Request Rejected Successfully',
                                          ).show());
                                    },
                                    child: const Text(
                                      "REJECT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2 - 100,
                        ),
                        CircularProgressIndicator(
                          color: mainColor,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<TimeRequestModel> updateTimeRequest(
      int? transactionId,
      String? dueDate,
      String? newDate,
      int? userId,
      int? timeRequestId,
      String? status,
      int? vendorId,
      String? message) async {
    final response = await http.put(
      Uri.https(baseUrl, "/timeRequest/updateTimeRequest"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
        'timeRequestId': timeRequestId,
        'vendorId': vendorId,
        'transactionId': transactionId,
        'status': status,
        'message': message,
        'newDate': newDate,
        'dueDate': dueDate,
      }),
    );

    if (response.statusCode == 200) {
      return TimeRequestModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update time request.');
    }
  }

  Future<bool> updateTransaction(
      int transactionId,
      int userId,
      String? dueDate,
      int amount,
      String creditDebitStatus,
      String status,
      String transactionDate,
      int vendorId,
      String paymentStatus) async {
    final response = await http.put(
      Uri.https(baseUrl, "/transaction/updateTransaction"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
        'transactionId': transactionId,
        'vendorId': vendorId,
        'status': status,
        'paymentStatus': paymentStatus,
        'creditDebitStatus': creditDebitStatus,
        'amount': amount,
        'dueDate': dueDate,
        'transactionDate': transactionDate,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update transaction.');
    }
  }
}
