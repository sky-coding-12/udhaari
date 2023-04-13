import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_it/privacy_and_policy.dart';

import '../All_Users/Vendor/Screens/qr_code_screen.dart';
import '../All_Users/Vendor/Screens/update_vendor_profile.dart';
import '../All_Users/Vendor/Screens/vendor_dashboard.dart';
import '../All_Users/Vendor/Screens/view_profile_screen.dart';
import '../Constant/const_variable.dart';
import '../FAQs_screen.dart';
import '../myApp.dart';
import '../provider/vendor_auth_provider.dart';
import '../support_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<VendorAuthProvider>(context, listen: false);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(ap.vendorModel.profilePic),
                  radius: 60.0,
                ),
                const SizedBox(height: 5.0),
                Text(
                  ap.vendorModel.shopName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                )
              ],
            ),
            const SizedBox(height: 5.0),
            const Divider(color: Colors.black54),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const VendorDashBoard()));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.home_outlined,
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
                        builder: (context) => ViewVendorProfile(
                            phone: ap.vendorModel.phoneNumber.substring(3))));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.account_box_outlined,
                        size: 27.0,
                      ),
                      SizedBox(width: 12.0),
                      Text("View Profile"),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpdateVendorProfile(
                            phone: ap.vendorModel.phoneNumber.substring(3))));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.mode_edit_outline_outlined,
                        size: 27.0,
                      ),
                      SizedBox(width: 12.0),
                      Text("Update Profile"),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: const [
                    Icon(
                      Icons.history_edu,
                      size: 27.0,
                    ),
                    SizedBox(width: 12.0),
                    Text("Transaction History"),
                  ],
                ),
                const SizedBox(height: 12.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QR_Code_Screen(
                            phone: ap.vendorModel.phoneNumber.substring(3))));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.qr_code,
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
                        Icons.call_outlined,
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
                        Icons.logout,
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
