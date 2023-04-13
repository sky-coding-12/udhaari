import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

import '../../../Components/customVendorDrawer.dart';
import '../../../Constant/const_variable.dart';
import '../../../myApp.dart';
import '../../../provider/vendor_auth_provider.dart';
import '../../../services/api_calling.dart';
import 'particular_user.dart';
import 'qr_code_screen.dart';

class VendorDashBoard extends StatefulWidget {
  const VendorDashBoard({Key? key}) : super(key: key);

  @override
  State<VendorDashBoard> createState() => _VendorDashBoardState();
}

class _VendorDashBoardState extends State<VendorDashBoard> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<VendorAuthProvider>(context, listen: false);
    return AdvancedDrawer(
      backdropColor: const Color(0xFFE4F2F9),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
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
          body: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          _advancedDrawerController.showDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: mainColor,
                        ),
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
                              Icons.qr_code_2,
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
                                          builder: (context) => const MyApp()),
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
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30.0),
                  FutureBuilder(
                    future: fetchParticularVendor(
                        ap.vendorModel.phoneNumber.substring(3)),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Text("${snapshot.error}");
                      } else {
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
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 5.0),
                  const Divider(thickness: 2.0),
                  const SizedBox(height: 5.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "User List",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: mainColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  FutureBuilder(
                    future: fetchAllUsers(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Text("${snapshot.error}");
                      } else {
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
                                      phone: snapshot.data[index].phoneNumber,
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
                                            Text(
                                                "${snapshot.data[index].email}"),
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
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
