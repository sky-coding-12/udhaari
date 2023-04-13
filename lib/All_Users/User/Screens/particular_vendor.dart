import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/vendor_spring_boot_model.dart';
import '../../../services/api_calling.dart';
import 'all_time_request_messages.dart';
import 'credit_amount_screen.dart';

class ParticularVendor extends StatefulWidget {
  final int vendorPhone;
  final String userPhone;
  const ParticularVendor(
      {Key? key, required this.vendorPhone, required this.userPhone})
      : super(key: key);

  @override
  State<ParticularVendor> createState() => _ParticularVendorState();
}

class _ParticularVendorState extends State<ParticularVendor> {
  late Future<VendorSpringBootModel> vendor;
  late int vendorPhone;
  late String userPhone;

  @override
  void initState() {
    super.initState();
    vendorPhone = widget.vendorPhone;
    userPhone = widget.userPhone;
    setState(() {
      vendor = fetchParticularVendor(vendorPhone.toString());
    });
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
          actions: [
            IconButton(
              tooltip: "All Messages",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllTimeRequestMessages(
                              vendorPhone: vendorPhone,
                              userPhone: userPhone,
                            )));
              },
              icon: Icon(
                Icons.message,
                color: mainColor,
              ),
            ),
            IconButton(
              tooltip: "Remainder",
              onPressed: () {},
              icon: Icon(
                Icons.timer,
                color: mainColor,
              ),
            )
          ],
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  FutureBuilder(
                    future: vendor,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        return Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage("${snapshot.data!.image}"),
                              radius: 90.0,
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              snapshot.data!.shopName!.toUpperCase(),
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              "${snapshot.data!.vendorName}",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            FutureBuilder(
                                future: fetchParticularVendorCreditDebit(
                                    userPhone, vendorPhone.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Credit : ",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                      "₹ ${snapshot.data!.first}"),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Debit : ",
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                      "₹ ${snapshot.data!.last}"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Payable Amount : ",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: mainColor,
                                              ),
                                            ),
                                            Text(
                                              "${snapshot.data!.first - snapshot.data!.last}",
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return const SizedBox();
                                }),
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
                  const SizedBox(height: 5.0),
                  const Divider(thickness: 2.0),
                  const SizedBox(height: 5.0),
                  FutureBuilder(
                      future: fetchParticularVendorTransaction(
                          userPhone, vendorPhone.toString()),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12.0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              if (snapshot.data.length != 0) {
                                return GestureDetector(
                                  onTap: () {
                                    snapshot.data[index].creditDebitStatus ==
                                            "credit"
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreditAmountScreen(
                                                transactionId: snapshot
                                                    .data[index].transactionId,
                                                userPhone: userPhone,
                                                vendorPhone: vendorPhone,
                                                amount:
                                                    snapshot.data[index].amount,
                                              ),
                                            ),
                                          )
                                        : print("debit");
                                  },
                                  child: Card(
                                    clipBehavior: Clip.hardEdge,
                                    elevation: 8.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 100.0,
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                snapshot.data[index]
                                                            .creditDebitStatus ==
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
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16.0,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                snapshot.data[index]
                                                            .creditDebitStatus ==
                                                        "credit"
                                                    ? Row(
                                                        children: [
                                                          Text(
                                                            "Due Date : ",
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                color:
                                                                    mainColor),
                                                          ),
                                                          Text(
                                                            "${snapshot.data[index].dueDate}",
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return const Text("No Data Found");
                              }
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        return const SizedBox();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
