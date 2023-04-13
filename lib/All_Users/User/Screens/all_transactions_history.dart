import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/transaction_model.dart';
import '../../../services/api_calling.dart';

class TransactionHistory extends StatefulWidget {
  final String phone;
  const TransactionHistory({Key? key, required this.phone}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  late String phone;

  late Future<TransactionModel> transaction;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
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
            "Transaction History",
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 25.5,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FutureBuilder(
              future: fetchAllTransaction(phone),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data.length != 0) {
                        return Card(
                          clipBehavior: Clip.hardEdge,
                          elevation: 8.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 120.0,
                              child: Row(
                                children: [
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Transaction ID : ",
                                            style: TextStyle(
                                              color: mainColor,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data[index].transactionId} ",
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      snapshot.data[index].creditDebitStatus ==
                                              "credit"
                                          ? Row(
                                              children: [
                                                Text(
                                                  "${snapshot.data[index].creditDebitStatus} : "
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                Text(
                                                  "${snapshot.data[index].amount}",
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Text(
                                                  "${snapshot.data[index].creditDebitStatus} : "
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                Text(
                                                  "${snapshot.data[index].amount}",
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                      Row(
                                        children: [
                                          Text(
                                            "Transaction Date : ",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: mainColor),
                                          ),
                                          Text(
                                            "${snapshot.data[index].transactionDate}",
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      snapshot.data[index].creditDebitStatus ==
                                              "credit"
                                          ? Row(
                                              children: [
                                                Text(
                                                  "Due Date : ",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: mainColor),
                                                ),
                                                Text(
                                                  "${snapshot.data[index].dueDate}",
                                                  style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                      Row(
                                        children: [
                                          Text(
                                            "Vendor Number : ",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: mainColor),
                                          ),
                                          Text(
                                            "${snapshot.data[index].vendorId}",
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Text("No Data Found");
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
