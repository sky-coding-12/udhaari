import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/RemainderModel.dart';
import '../../../Models/transaction_model.dart';
import '../../../Models/user_spring_boot_model.dart';
import '../../../services/api_calling.dart';

class SendRemainderToUser extends StatefulWidget {
  final int transactionId;
  final int userPhone;
  final int vendorPhone;
  const SendRemainderToUser(
      {Key? key,
      required this.transactionId,
      required this.userPhone,
      required this.vendorPhone})
      : super(key: key);

  @override
  State<SendRemainderToUser> createState() => _SendRemainderToUserState();
}

class _SendRemainderToUserState extends State<SendRemainderToUser> {
  late Future<UserSpringBootModel> user;
  late Future<TransactionModel> transaction;

  late int transactionId;
  late int userPhone;
  late int vendorPhone;
  late int dayRemain;
  late String dueDate;
  late String customerName;

  late DateTime payDate;
  final currDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    transactionId = widget.transactionId;
    userPhone = widget.userPhone;
    vendorPhone = widget.vendorPhone;
    setState(() {
      transaction = fetchOneTransaction(transactionId.toString());
      user = fetchUser(userPhone.toString());
    });
    user.then((value) => {
          customerName = value.userName!,
        });
    List<String> splitted;
    int day;
    int month;
    int year;
    transaction
        .then((value) => {
              dueDate = value.dueDate!,
            })
        .then((value) => {
              splitted = dueDate.split('/'),
              day = int.parse(splitted[1]),
              month = int.parse(splitted[0]),
              year = int.parse(splitted[2]),
              payDate = DateTime(year, month, day),
              dayRemain = payDate.difference(currDate).inDays,
            });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              color: mainColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Send Remainder",
            style: TextStyle(
              color: mainColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
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
                future: transaction,
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
                                    "Customer Name : ",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: mainColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    customerName,
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
                                    "Customer No : ",
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    "Transaction Date : ",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: mainColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    "${snapshot.data!.transactionDate}",
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
                                    "Remaining Days : ",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: mainColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    "$dayRemain",
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
                                    "Status : ",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: mainColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    "${snapshot.data!.status}",
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.065,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromRGBO(63, 72, 204, 1))),
                            child: const Text(
                              "SEND REMAINDER",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            onPressed: () async {
                              String message =
                                  "Your last date for transaction is ${snapshot.data!.dueDate} and you have only $dayRemain days to pay for ${snapshot.data!.amount} rupees.";
                              List<String> userNumber = [userPhone.toString()];
                              await sendSMS(
                                      message: message, recipients: userNumber)
                                  .catchError((onError) {
                                print("akash");
                              }).whenComplete(
                                () => sendRemainder(
                                  userPhone,
                                  vendorPhone,
                                  DateFormat.yMd().format(DateTime.now()),
                                ).then((value) => {
                                      AwesomeDialog(
                                        context: context,
                                        headerAnimationLoop: true,
                                        animType: AnimType.scale,
                                        btnCancelColor: mainColor,
                                        dialogType: DialogType.success,
                                        btnOkOnPress: () {
                                          Navigator.pop(context);
                                        },
                                        btnOkColor: mainColor,
                                        title: 'Success',
                                        desc: 'Message Send Successfully 😊',
                                      ).show(),
                                    }),
                              );
                            },
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

  Future<RemainderModel> sendRemainder(
      int userPhone, int vendorPhone, String sendTime) async {
    String url = "https://$baseUrl/reminder/saveReminder";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userPhone,
        'vendorId': vendorPhone,
        'sendTime': sendTime,
      }),
    );

    if (response.statusCode == 200) {
      return RemainderModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send remainder.');
    }
  }
}
