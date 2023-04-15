import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/time_request_model.dart';
import '../../../services/api_calling.dart';
import 'update_time_request.dart';

class UserTimeRequests extends StatefulWidget {
  final String vendorPhone;
  final int userPhone;
  const UserTimeRequests(
      {Key? key, required this.vendorPhone, required this.userPhone})
      : super(key: key);

  @override
  State<UserTimeRequests> createState() => _UserTimeRequestsState();
}

class _UserTimeRequestsState extends State<UserTimeRequests> {
  late String vendorPhone;
  late int userPhone;

  late Future<List<TimeRequestModel>> allRequests;

  @override
  void initState() {
    super.initState();
    vendorPhone = widget.vendorPhone;
    userPhone = widget.userPhone;
    setState(() {
      allRequests = getTimeRequest(vendorPhone, userPhone.toString());
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
                        builder: (context) => UserTimeRequests(
                              userPhone: userPhone,
                              vendorPhone: vendorPhone,
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
                future: allRequests,
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
                                    GestureDetector(
                                      onTap: () {
                                        snapshot.data[index].status == "Pending"
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateTimeRequest(
                                                          requestId: snapshot
                                                              .data[index]
                                                              .timeRequestId,
                                                          transactionId: snapshot
                                                              .data[index]
                                                              .transactionId,
                                                        )))
                                            : print("");
                                      },
                                      child: Column(
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
                                          FutureBuilder(
                                            future: fetchOneTransaction(snapshot
                                                .data[index].transactionId
                                                .toString()),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    "${snapshot.error}");
                                              } else if (snapshot.hasData) {
                                                return Row(
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
                                                        color: Colors.black54,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                              return const SizedBox();
                                            },
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
                                          const SizedBox(height: 5.0),
                                          Row(
                                            children: [
                                              Text(
                                                "Due Date : ",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: mainColor),
                                              ),
                                              Text(
                                                "${snapshot.data[index]!.dueDate}",
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
