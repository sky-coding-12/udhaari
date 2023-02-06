import 'package:flutter/material.dart';

import 'Bank/bank_login.dart';
import 'Components/customButton.dart';
import 'Constant/const_variable.dart';
import 'User/Credential/user_login.dart';
import 'Vendor/vendor_login.dart';

class WhoAreYou extends StatelessWidget {
  const WhoAreYou({Key? key}) : super(key: key);

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
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserLogin()),
                      ),
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
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VendorLogin()),
                      ),
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
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BankLogin()),
                      ),
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
