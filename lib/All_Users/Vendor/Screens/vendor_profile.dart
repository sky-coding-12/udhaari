import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/const_variable.dart';
import '../../../FAQs_screen.dart';
import '../../../Models/vendor_spring_boot_model.dart';
import '../../../myApp.dart';
import '../../../privacy_and_policy.dart';
import '../../../provider/vendor_auth_provider.dart';
import '../../../services/api_calling.dart';
import '../../../support_screen.dart';
import 'all_vendor_transactions.dart';
import 'qr_code_screen.dart';
import 'update_vendor_profile.dart';
import 'view_profile_screen.dart';

class VendorProfile extends StatefulWidget {
  const VendorProfile({Key? key}) : super(key: key);

  @override
  State<VendorProfile> createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: vendor,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            backgroundImage:
                                NetworkImage("${snapshot.data!.image}"),
                            radius: 90.0,
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircleAvatar(
                          radius: 90.0,
                          backgroundColor: mainColor,
                          child: const Icon(
                            CupertinoIcons.person,
                            color: Colors.white,
                            size: 70.0,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 5.0),
                    FutureBuilder(
                        future: vendor,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Text(
                                  snapshot.data!.vendorName!.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                ),
                                Text(
                                  "${snapshot.data!.shopName}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return Text(
                            "Username",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: mainColor,
                            ),
                          );
                        }),
                  ],
                ),
                const SizedBox(height: 5.0),
                const Divider(color: Colors.black54),
                Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewVendorProfile(
                                      phone: ap.vendorModel.phoneNumber
                                          .substring(3))));
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  CupertinoIcons.profile_circled,
                                  size: 27.0,
                                ),
                                SizedBox(width: 12.0),
                                Text("View Profile"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 50.0,
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UpdateVendorProfile(
                                      phone: ap.vendorModel.phoneNumber
                                          .substring(3))));
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  CupertinoIcons.pen,
                                  size: 27.0,
                                ),
                                SizedBox(width: 12.0),
                                Text("Update Profile"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllVendorTransactions(
                                phone:
                                    ap.vendorModel.phoneNumber.substring(3))));
                      },
                      child: SizedBox(
                        height: 50.0,
                        child: Card(
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Icon(
                                  CupertinoIcons.rectangle_3_offgrid_fill,
                                  size: 27.0,
                                ),
                                SizedBox(width: 12.0),
                                Text("Transaction History"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 50.0,
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => QR_Code_Screen(
                                      phone: ap.vendorModel.phoneNumber
                                          .substring(3))));
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  CupertinoIcons.qrcode,
                                  size: 27.0,
                                ),
                                SizedBox(width: 12.0),
                                Text("QR Code"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 50.0,
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FAQs_Screen()));
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.policy_outlined,
                                  size: 27.0,
                                ),
                                SizedBox(width: 12.0),
                                Text("FAQs"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 50.0,
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PrivacyAndPolicy()));
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.privacy_tip_outlined,
                                  size: 27.0,
                                ),
                                SizedBox(width: 12.0),
                                Text("Privacy & Policy"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 50.0,
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SupportScreen()));
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  CupertinoIcons.phone_circle,
                                  size: 27.0,
                                ),
                                SizedBox(width: 12.0),
                                Text("Support"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 50.0,
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              ap.vendorSignOut().then((value) =>
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const MyApp()),
                                      (route) => false));
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  CupertinoIcons.lock_slash,
                                  size: 27.0,
                                ),
                                SizedBox(width: 12.0),
                                Text("Logout"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
