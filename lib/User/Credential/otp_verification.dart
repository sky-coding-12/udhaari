import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Components/customButton.dart';
import '../../Constant/const_variable.dart';
import '../../Modules/visibility_model.dart';
import '../Screens/user_dashboard.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _SetOtpVerification();
}

class _SetOtpVerification extends State<OtpVerification> {
  late TextEditingController _pinController;

  bool validOTP = false;

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
                        return TextField(
                          maxLength: 4,
                          keyboardType: TextInputType.phone,
                          onChanged: (val) => {
                            myModel.changeOTPValidation(val),
                            if (myModel.isOTPValid)
                              {
                                validOTP = true,
                              }
                            else
                              {
                                validOTP = false,
                              }
                          },
                          controller: _pinController,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 22.0,
                              vertical: 12.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color:
                                    myModel.isOTPValid ? mainColor : Colors.red,
                                width: 1.5,
                              ),
                            ),
                            hintText: "OTP",
                            prefixIcon: Icon(
                              Icons.code,
                              color: mainColor,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12.0),
                    GestureDetector(
                      onTap: () => {
                        if (validOTP)
                          {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const UserDashboard()),
                            ),
                          }
                        else
                          {
                            AwesomeDialog(
                              context: context,
                              headerAnimationLoop: true,
                              animType: AnimType.scale,
                              btnCancelColor: mainColor,
                              dialogType: DialogType.error,
                              btnCancelOnPress: () {},
                              title: 'Invalid OTP',
                              desc: 'Please, enter correct OTP',
                            ).show(),
                          }
                      },
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
