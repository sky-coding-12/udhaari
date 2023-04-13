import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../Components/customUserDrawer.dart';
import '../../../Constant/const_variable.dart';
import '../../../Models/user_spring_boot_model.dart';
import '../../../myApp.dart';
import '../../../provider/user_auth_provider.dart';
import '../../../services/api_calling.dart';
import 'particular_vendor.dart';
import 'qr_code_scan_screen.dart';
import 'qr_code_screen.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _advancedDrawerController = AdvancedDrawerController();

  late Future<UserSpringBootModel> user;

  var ap;
  @override
  void initState() {
    super.initState();
    setState(() {
      ap = Provider.of<UserAuthProvider>(context, listen: false);
      user = fetchUser(ap.userModel.phoneNumber.substring(3));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: const Color(0xFFE4F2F9),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: const CustomDrawer(),
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: user,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage("${snapshot.data!.image}"),
                                ),
                                onTap: () {
                                  _advancedDrawerController.toggleDrawer();
                                },
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    tooltip: "QR code",
                                    onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  QR_Code_Screen(
                                                    phone:
                                                        "${snapshot.data!.phoneNumber}",
                                                  ))),
                                    },
                                    icon: Icon(
                                      Icons.qr_code_2,
                                      color: mainColor,
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: "Log Out",
                                    onPressed: () => {
                                      ap.userSignOut().then((value) =>
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyApp()),
                                              (route) => false)),
                                    },
                                    icon: Icon(
                                      Icons.logout,
                                      color: mainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        return SizedBox();
                      }),
                  SizedBox(height: MediaQuery.of(context).size.height / 30.0),
                  FutureBuilder(
                    future: user,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: Column(
                            children: [
                              CircularPercentIndicator(
                                radius: 90,
                                lineWidth: 20.0,
                                percent: snapshot.data!.creditScore! / 100,
                                animation: true,
                                animationDuration: 2000,
                                circularStrokeCap: CircularStrokeCap.round,
                                center: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${snapshot.data!.creditScore}",
                                      style: const TextStyle(
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "Credit Score",
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ],
                                ),
                                progressColor: mainColor,
                                backgroundColor:
                                    const Color.fromRGBO(63, 72, 204, 0.4),
                              ),
                              const SizedBox(height: 17.0),
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
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("₹ ${snapshot.data!.totalCredit}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Debit : ",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("₹ ${snapshot.data!.totalDebit}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return SizedBox();
                    },
                  ),
                  const SizedBox(height: 5.0),
                  const Divider(thickness: 2.0),
                  const SizedBox(height: 5.0),
                  FutureBuilder(
                    future: fetchAllVendorsOnCredit(
                        ap.userModel.phoneNumber.substring(3)),
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
                                elevation: 2.0,
                                child: InkWell(
                                  onTap: () => {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ParticularVendor(
                                        vendorPhone:
                                            snapshot.data[index].phoneNumber,
                                        userPhone: ap.userModel.phoneNumber
                                            .substring(3),
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
                                                "${snapshot.data[index]!.image}",
                                                scale: 1.0),
                                          ),
                                          const SizedBox(width: 10.0),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${snapshot.data[index].vendorName}",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: mainColor),
                                              ),
                                              Text(
                                                  "${snapshot.data[index].shopName}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Text("No Data Found");
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
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QR_Scan_Screen(
                            userPhone: ap.userModel.phoneNumber.substring(3),
                          )));
            },
            backgroundColor: mainColor,
            tooltip: "Scan QR",
            child: const Icon(Icons.qr_code_scanner),
          ),
        ),
      ),
    );
  }
}
