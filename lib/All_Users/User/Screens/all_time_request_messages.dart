import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/vendor_spring_boot_model.dart';
import '../../../services/api_calling.dart';

class AllTimeRequestMessages extends StatefulWidget {
  final int vendorPhone;
  final String userPhone;
  const AllTimeRequestMessages(
      {Key? key, required this.vendorPhone, required this.userPhone})
      : super(key: key);

  @override
  State<AllTimeRequestMessages> createState() => _AllTimeRequestMessagesState();
}

class _AllTimeRequestMessagesState extends State<AllTimeRequestMessages> {
  late int vendorPhone;
  late String userPhone;
  late String vendorName;
  late String shopName;
  late Future<VendorSpringBootModel> vendor;

  @override
  void initState() {
    super.initState();
    vendorPhone = widget.vendorPhone;
    userPhone = widget.userPhone;
    setState(() {
      vendor = fetchParticularVendor(vendorPhone.toString());
    });
    vendor.then((value) => {
          vendorName = value.vendorName!,
          shopName = value.shopName!,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Time Requests",
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontSize: 25.5,
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
                          )));
            },
            icon: Icon(
              Icons.change_circle,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      snapshot.data[index].status ==
                                                  "Pending" ||
                                              snapshot.data[index].status ==
                                                  "Reject"
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
                                                    fontWeight: FontWeight.bold,
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
                                                    fontWeight: FontWeight.bold,
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
                                            "$vendorName",
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
                                            "$shopName",
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
                return Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
