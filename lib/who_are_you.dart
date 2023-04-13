import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_it/All_Users/Bank/Screens/bank_dashboard.dart';
import 'package:take_it/All_Users/User/Screens/user_dashboard.dart';
import 'package:take_it/All_Users/Vendor/Screens/vendor_dashboard.dart';
import 'package:take_it/provider/bank_auth_provider.dart';
import 'package:take_it/provider/vendor_auth_provider.dart';

import 'All_Users/Bank/Credential/bank_login.dart';
import 'All_Users/User/Credential/user_login.dart';
import 'All_Users/Vendor/Credential/vendor_login.dart';
import 'Components/customButton.dart';
import 'Constant/const_variable.dart';
import 'provider/user_auth_provider.dart';

class WhoAreYou extends StatefulWidget {
  const WhoAreYou({Key? key}) : super(key: key);

  @override
  State<WhoAreYou> createState() => _WhoAreYouState();
}

class _WhoAreYouState extends State<WhoAreYou> {
  var ap_user;
  var ap_vendor;
  var ap_bank;

  @override
  void initState() {
    super.initState();
    setState(() {
      ap_user = Provider.of<UserAuthProvider>(context, listen: false);
      ap_vendor = Provider.of<VendorAuthProvider>(context, listen: false);
      ap_bank = Provider.of<BankAuthProvider>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontSize: 25.5,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/who_are_you.png"),
                    ),
                  ),
                ),
                const Text(
                  "Who are you?",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (ap_user.isSignedIn == true && ap_user.isNotEmptyStr) {
                        await ap_user.getUserDataFromSP().whenComplete(
                              () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserDashboard(),
                                ),
                              ),
                            );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserLogin(),
                          ),
                        );
                      }
                    },
                    child: CustomButton(
                      btnText: 'Customer',
                    ),
                  ),
                ),
                const Text(
                  "OR",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (ap_vendor.isSignedIn == true &&
                          ap_vendor.isNotEmptyStr) {
                        await ap_vendor.getVendorDataFromSP().whenComplete(
                              () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const VendorDashBoard(),
                                ),
                              ),
                            );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VendorLogin(),
                          ),
                        );
                      }
                    },
                    child: CustomButton(
                      btnText: 'Vendor',
                    ),
                  ),
                ),
                const Text(
                  "OR",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (ap_bank.isSignedIn == true && ap_bank.isNotEmptyStr) {
                        await ap_bank.getBankDataFromSP().whenComplete(
                              () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BankDashBoard(),
                                ),
                              ),
                            );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BankLogin(),
                          ),
                        );
                      }
                    },
                    child: CustomButton(
                      btnText: 'Bank',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
