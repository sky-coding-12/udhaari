import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/vendor_spring_boot_model.dart';
import '../../../services/api_calling.dart';

class ViewVendorProfile extends StatefulWidget {
  final String phone;
  const ViewVendorProfile({Key? key, required this.phone}) : super(key: key);

  @override
  State<ViewVendorProfile> createState() => _ViewVendorProfileState();
}

class _ViewVendorProfileState extends State<ViewVendorProfile> {
  late String phone;
  late Future<VendorSpringBootModel> vendor;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    setState(() {
      vendor = fetchParticularVendor(phone);
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
          "Vendor Profile",
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontSize: 25.5,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FutureBuilder(
                future: vendor,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage("${snapshot.data!.image}"),
                            radius: 120,
                          ),
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
                                      "Vendor name : ",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: mainColor,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      snapshot.data!.vendorName!.toUpperCase(),
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
                          SizedBox(height: 5.0),
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
                                      "Shop name : ",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: mainColor,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      "${snapshot.data!.shopName}",
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
                          SizedBox(height: 5.0),
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
                                      "Address : ",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: mainColor,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      "${snapshot.data!.address}",
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
                          SizedBox(height: 5.0),
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
                                      "Email : ",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: mainColor,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      "${snapshot.data!.email}",
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
                          SizedBox(height: 5.0),
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
                                      "Phone Number : ",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: mainColor,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      "${snapshot.data!.phoneNumber}",
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
                          SizedBox(height: 5.0),
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
                                      "Total Loan Amount : ",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: mainColor,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      "${snapshot.data!.totalLoanAmount}",
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
                          SizedBox(height: 5.0),
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
                                      "Total Debit : ",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: mainColor,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      "${snapshot.data!.totalDebit}",
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
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator(
                    color: mainColor,
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
