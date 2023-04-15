import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_it/All_Users/User/Screens/user_dashboard.dart';

import '../All_Users/User/Screens/all_transactions_history.dart';
import '../All_Users/User/Screens/qr_code_screen.dart';
import '../All_Users/User/Screens/update_user_profile.dart';
import '../All_Users/User/Screens/view_profile_screen.dart';
import '../Constant/const_variable.dart';
import '../FAQs_screen.dart';
import '../Models/user_spring_boot_model.dart';
import '../myApp.dart';
import '../privacy_and_policy.dart';
import '../provider/user_auth_provider.dart';
import '../services/api_calling.dart';
import '../support_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: user,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        backgroundImage:
                            NetworkImage("${snapshot.data!.image}"),
                        radius: 60.0,
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircleAvatar(
                      radius: 60.0,
                      backgroundColor: mainColor,
                    );
                  },
                ),
                const SizedBox(height: 5.0),
                FutureBuilder(
                    future: user,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.userName!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return SizedBox();
                    }),
              ],
            ),
            const SizedBox(height: 5.0),
            const Divider(color: Colors.black54),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UserDashboard()));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        CupertinoIcons.home,
                        size: 27.0,
                      ),
                      SizedBox(width: 12.0),
                      Text("Home"),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewUserProfile(
                            phone: ap.userModel.phoneNumber.substring(3))));
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
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpdateUserProfile(
                            phone: ap.userModel.phoneNumber.substring(3))));
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
                const SizedBox(height: 12.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TransactionHistory(
                            phone: ap.userModel.phoneNumber.substring(3))));
                  },
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
                const SizedBox(height: 12.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QR_Code_Screen(
                            phone: ap.userModel.phoneNumber.substring(3))));
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
                const SizedBox(height: 12.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FAQs_Screen()));
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
                const SizedBox(height: 12.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyAndPolicy()));
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
                const SizedBox(height: 12.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SupportScreen()));
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
                const SizedBox(height: 12.0),
                GestureDetector(
                  onTap: () {
                    ap.userSignOut().then((value) =>
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
              ],
            ),
            const Spacer(),
            const Center(
              child: Text("©2023 take_it 🗿 | all rights reserved"),
            ),
          ],
        ),
      ),
    );
  }
}
