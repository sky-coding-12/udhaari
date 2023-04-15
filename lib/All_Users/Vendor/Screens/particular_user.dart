import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/user_spring_boot_model.dart';
import '../../../services/api_calling.dart';
import 'all_time_request_message_user.dart';
import 'send_remainder_to_user.dart';

class ParticularUser extends StatefulWidget {
  final String vendorPhone;
  final int userPhone;
  const ParticularUser(
      {Key? key, required this.vendorPhone, required this.userPhone})
      : super(key: key);

  @override
  State<ParticularUser> createState() => _ParticularUserState();
}

class _ParticularUserState extends State<ParticularUser> {
  late Future<UserSpringBootModel> user;
  late String vendorPhone;
  late int userPhone;

  @override
  void initState() {
    super.initState();
    vendorPhone = widget.vendorPhone;
    userPhone = widget.userPhone;
    setState(() {
      user = fetchUser(userPhone.toString());
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
            title,
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          actions: [
            FutureBuilder(
              future: user,
              builder: (builder, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  return IconButton(
                    tooltip: "All Messages",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserTimeRequests(
                                    userPhone: userPhone,
                                    vendorPhone: vendorPhone,
                                  )));
                    },
                    icon: Icon(
                      CupertinoIcons.text_bubble,
                      color: mainColor,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            IconButton(
              tooltip: "Remainder",
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.clock,
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
                    future: user,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage("${snapshot.data!.image}"),
                              radius: 90.0,
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              snapshot.data!.userName!.toUpperCase(),
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 18.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Phone Number : ",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  "${snapshot.data!.phoneNumber}",
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            const Divider(thickness: 2.0),
                            const SizedBox(height: 5.0),
                            FutureBuilder(
                              future: fetchParticularVendorTransaction(
                                  userPhone.toString(), vendorPhone),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                } else if (snapshot.hasData) {
                                  return ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 12.0),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      if (snapshot.data.length != 0) {
                                        return GestureDetector(
                                          onTap: () {
                                            snapshot.data[index]
                                                            .creditDebitStatus ==
                                                        "credit" &&
                                                    snapshot.data[index]
                                                            .paymentStatus ==
                                                        "Pending"
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SendRemainderToUser(
                                                              transactionId:
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .transactionId,
                                                              userPhone:
                                                                  userPhone,
                                                              vendorPhone: int.parse(vendorPhone),
                                                            )))
                                                : print("");
                                          },
                                          child: Card(
                                            clipBehavior: Clip.hardEdge,
                                            elevation: 8.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 90.0,
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 10.0),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // Row(
                                                        //   children: [
                                                        //     Text(
                                                        //       "Transaction ID : ",
                                                        //       style: TextStyle(
                                                        //         color: mainColor,
                                                        //         fontSize: 16.0,
                                                        //       ),
                                                        //     ),
                                                        //     Text(
                                                        //       "${snapshot.data[index].transactionId} ",
                                                        //       style: const TextStyle(
                                                        //         color: Colors.black54,
                                                        //         fontWeight:
                                                        //             FontWeight.bold,
                                                        //         fontSize: 16.0,
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        snapshot.data[index]
                                                                    .creditDebitStatus ==
                                                                "credit"
                                                            ? Row(
                                                                children: [
                                                                  Text(
                                                                    "${snapshot.data[index].creditDebitStatus} : "
                                                                        .toUpperCase(),
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          mainColor,
                                                                      fontSize:
                                                                          16.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "${snapshot.data[index].amount}",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16.0,
                                                                      color: Colors
                                                                          .red,
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
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          mainColor,
                                                                      fontSize:
                                                                          16.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "${snapshot.data[index].amount}",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16.0,
                                                                      color: Colors
                                                                          .green,
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
                                                                  fontSize:
                                                                      16.0,
                                                                  color:
                                                                      mainColor),
                                                            ),
                                                            Text(
                                                              "${snapshot.data[index].transactionDate}",
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
                                                        ),
                                                        snapshot.data[index]
                                                                    .creditDebitStatus ==
                                                                "credit"
                                                            ? Row(
                                                                children: [
                                                                  Text(
                                                                    "Due Date : ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16.0,
                                                                        color:
                                                                            mainColor),
                                                                  ),
                                                                  Text(
                                                                    "${snapshot.data[index].dueDate}",
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          16.0,
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
                                }
                                return const SizedBox();
                              },
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
                              height:
                                  MediaQuery.of(context).size.height / 2 - 100,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
