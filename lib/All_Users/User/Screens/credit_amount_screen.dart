import 'package:flutter/material.dart';
import 'package:take_it/All_Users/User/Screens/payment_screen.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/transaction_model.dart';
import '../../../services/api_calling.dart';
import 'send_message_screen.dart';

class CreditAmountScreen extends StatefulWidget {
  final int transactionId;
  final int amount;
  final int vendorPhone;
  final String userPhone;
  const CreditAmountScreen(
      {Key? key,
      required this.transactionId,
      required this.vendorPhone,
      required this.userPhone,
      required this.amount})
      : super(key: key);

  @override
  State<CreditAmountScreen> createState() => _CreditAmountScreenState();
}

class _CreditAmountScreenState extends State<CreditAmountScreen> {
  late int transactionId;
  late int amount;
  late int vendorPhone;
  late String userPhone;
  late String dueDate;

  late Future<TransactionModel> transaction;

  @override
  void initState() {
    super.initState();
    transactionId = widget.transactionId;
    amount = widget.amount;
    vendorPhone = widget.vendorPhone;
    userPhone = widget.userPhone;
    setState(() {
      transaction = fetchOneTransaction(transactionId.toString());
    });
    transaction.then(
      (value) => value.dueDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: mainColor,
              ),
            ),
            centerTitle: true,
            title: Text(
              title,
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 25.5,
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
                child: Column(
                  children: [
                    const Text(
                      "Transaction Details",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    FutureBuilder(
                      future: transaction,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else if (snapshot.hasData) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 80.0,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "User Phone No : ",
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
                              const SizedBox(height: 8.0),
                              SizedBox(
                                height: 80.0,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Vendor Phone No : ",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: mainColor,
                                          ),
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          "${snapshot.data!.vendorId}",
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
                              const SizedBox(height: 8.0),
                              SizedBox(
                                height: 80.0,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
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
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              SizedBox(
                                height: 80.0,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              const SizedBox(height: 8.0),
                              SizedBox(
                                height: 80.0,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              const SizedBox(height: 10.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.92,
                                height:
                                    MediaQuery.of(context).size.height * 0.065,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SendMessageScreen(
                                                  vendorPhone:
                                                      vendorPhone.toString(),
                                                  userPhone: userPhone,
                                                  transactionId: transactionId,
                                                )));
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromRGBO(63, 72, 204, 1))),
                                  child: const Text(
                                    "SEND MESSAGE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: mainColor,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FutureBuilder(
            future: transaction,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
              } else if (snapshot.hasData) {
                return FloatingActionButton(
                  backgroundColor: mainColor,
                  child: const Icon(Icons.payments),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                                  userPhone: userPhone,
                                  vendorPhone: vendorPhone.toString(),
                                  amount: amount,
                                  dueDate: snapshot.data!.dueDate!,
                                )));
                  },
                );
              }
              return const SizedBox();
            },
          )),
    );
  }
}
