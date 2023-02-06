import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Components/customButton.dart';
import 'Components/customTextField.dart';
import 'Constant/const_variable.dart';
import 'Modules/visibility_model.dart';
import 'User/Screens/user_dashboard.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _SetOtpVerification();
}

class _SetOtpVerification extends State<OtpVerification> {
  late TextEditingController _pinController;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ChangeNotifierProvider<VisibilityModel>(
            create: (context) => VisibilityModel(),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 25.0),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/otp.png"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      "OTP Verification",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Consumer<VisibilityModel>(
                      builder: (context, myModel, child) {
                        return CustomTextField(
                          inputType: TextInputType.number,
                          hint: "OTP",
                          controller: _pinController,
                          maxLength: 4,
                          prefixIcon: Icon(
                            Icons.code,
                            color: mainColor,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12.0),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const UserDashboard()),
                      ),
                      child: CustomButton(
                        btnText: "CONFIRM OTP",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
