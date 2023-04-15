import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../services/api_calling.dart';

class AllTimeRequestMessages extends StatefulWidget {
  final int vendorPhone;
  final String userPhone;
  final String vendorName;
  final String shopName;
  const AllTimeRequestMessages(
      {Key? key,
      required this.vendorPhone,
      required this.userPhone,
      required this.vendorName,
      required this.shopName})
      : super(key: key);

  @override
  State<AllTimeRequestMessages> createState() => _AllTimeRequestMessagesState();
}

class _AllTimeRequestMessagesState extends State<AllTimeRequestMessages> {
  late int vendorPhone;
  late String userPhone;
  late String vendorName;
  late String shopName;

  @override
  void initState() {
    super.initState();
    vendorPhone = widget.vendorPhone;
    userPhone = widget.userPhone;
    vendorName = widget.vendorName;
    shopName = widget.shopName;
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
            "Time Requests",
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllTimeRequestMessages(
                              userPhone: userPhone,
                              vendorPhone: vendorPhone,
                              vendorName: vendorName,
                              shopName: shopName,
                            )));
              },
              icon: Icon(
                CupertinoIcons.refresh,
                size: 26.0,
                color: mainColor,
              ),
            ),
          ],
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: FutureBuilder(
                future: getTimeRequest(vendorPhone.toString(), userPhone),
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
                                height: 140.0,
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        snapshot.data[index].status ==
                                                    "Pending" ||
                                                snapshot.data[index].status ==
                                                    "Rejected"
                                            ? Row(
                                                children: [
                                                  Text(
                                                    "Status : ",
                                                    style: TextStyle(
                                                      color: mainColor,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${snapshot.data[index].status}",
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  Text(
                                                    "Status : ",
                                                    style: TextStyle(
                                                      color: mainColor,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${snapshot.data[index].status}",
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        const SizedBox(height: 5.0),
                                        Row(
                                          children: [
                                            Text(
                                              "Transaction ID : ",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: mainColor),
                                            ),
                                            Text(
                                              "${snapshot.data[index].transactionId}",
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5.0),
                                        Row(
                                          children: [
                                            Text(
                                              "Vendor Name : ",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: mainColor),
                                            ),
                                            Text(
                                              vendorName,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5.0),
                                        Row(
                                          children: [
                                            Text(
                                              "Shop Name : ",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: mainColor),
                                            ),
                                            Text(
                                              shopName,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5.0),
                                        Row(
                                          children: [
                                            Text(
                                              "New Date : ",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: mainColor),
                                            ),
                                            Text(
                                              "${snapshot.data[index].newDate}",
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
}
