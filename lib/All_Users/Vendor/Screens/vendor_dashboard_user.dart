import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/vendor_spring_boot_model.dart';
import '../../../myApp.dart';
import '../../../provider/vendor_auth_provider.dart';
import '../../../services/api_calling.dart';
import 'particular_user.dart';
import 'qr_code_screen.dart';
import 'view_profile_screen.dart';

class VendorDashBoard extends StatefulWidget {
  const VendorDashBoard({Key? key}) : super(key: key);

  @override
  State<VendorDashBoard> createState() => _VendorDashBoardState();
}

class _VendorDashBoardState extends State<VendorDashBoard> {
  late Future<VendorSpringBootModel> vendor;

  var ap;
  @override
  void initState() {
    super.initState();
    setState(() {
      ap = Provider.of<VendorAuthProvider>(context, listen: false);
      vendor = fetchParticularVendor(ap.vendorModel.phoneNumber.substring(3));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: vendor,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Container(
                              height: 35.0,
                              width: 35.0,
                              padding: const EdgeInsets.all(15.0),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/vendor.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewVendorProfile(
                                      phone: ap.vendorModel.phoneNumber
                                          .substring(3))));
                            },
                          ),
                          Row(
                            children: [
                              IconButton(
                                tooltip: "QR code",
                                onPressed: () => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => QR_Code_Screen(
                                          phone: ap.vendorModel.phoneNumber
                                              .substring(3)))),
                                },
                                icon: Icon(
                                  CupertinoIcons.qrcode,
                                  color: mainColor,
                                ),
                              ),
                              IconButton(
                                tooltip: "Log Out",
                                onPressed: () => {
                                  ap.vendorSignOut().then((value) =>
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyApp()),
                                          (route) => false)),
                                },
                                icon: Icon(
                                  CupertinoIcons.lock_slash,
                                  color: mainColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30.0),
                FutureBuilder(
                  future: vendor,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 80.0,
                              backgroundImage:
                                  NetworkImage("${snapshot.data!.image}"),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              snapshot.data!.shopName!.toUpperCase(),
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "TotalDebit Amount : ",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  "${snapshot.data!.totalDebit}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 5.0),
                const Divider(thickness: 2.0),
                const SizedBox(height: 5.0),
                FutureBuilder(
                  future: fetchAllUsersOnCredit(
                      ap.vendorModel.phoneNumber.substring(3)),
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
                          return Card(
                            clipBehavior: Clip.hardEdge,
                            elevation: 2.0,
                            child: InkWell(
                              onTap: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ParticularUser(
                                    userPhone: snapshot.data[index].phoneNumber,
                                    vendorPhone:
                                        ap.vendorModel.phoneNumber.substring(3),
                                  ),
                                )),
                              },
                              splashColor:
                                  const Color.fromRGBO(63, 72, 204, 0.2),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 60.0,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 35.0,
                                        backgroundImage: NetworkImage(
                                            "${snapshot.data[index]!.image}"),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${snapshot.data[index].userName}",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: mainColor),
                                          ),
                                          Text("${snapshot.data[index].email}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
