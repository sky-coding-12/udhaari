import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/const_variable.dart';
import '../../../Modules/visibility_model.dart';
import '../../../provider/bank_auth_provider.dart';
import '../../../who_are_you.dart';

class BankLogin extends StatefulWidget {
  const BankLogin({Key? key}) : super(key: key);

  @override
  State<BankLogin> createState() => _BankLoginState();
}

class _BankLoginState extends State<BankLogin> {
  late TextEditingController _phoneController;

  bool validPhone = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WhoAreYou(),
              ),
            ),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: mainColor,
            ),
          ),
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
        body: ChangeNotifierProvider<VisibilityModel>(
          create: (context) => VisibilityModel(),
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/login.png"),
                        ),
                      ),
                    ),
                    const Text(
                      "LOG IN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    const Text(
                      textAlign: TextAlign.center,
                      "Add your phone number, we'll send you a verification code",
                      style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Consumer<VisibilityModel>(
                      builder: (context, myModel, child) {
                        return TextField(
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          onChanged: (val) => {
                            myModel.changePhoneValidation(val),
                            if (myModel.isPhoneValid)
                              {
                                validPhone = true,
                              }
                            else
                              {
                                validPhone = false,
                              }
                          },
                          controller: _phoneController,
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
                                color: myModel.isPhoneValid
                                    ? mainColor
                                    : Colors.red,
                                width: 1.5,
                              ),
                            ),
                            hintText: "Phone Number",
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: mainColor,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.065,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromRGBO(63, 72, 204, 1))),
                          child: const Text(
                            "SEND OTP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onPressed: () => {
                                if (validPhone)
                                  {
                                    sendPhoneNumber(),
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
                                      title: 'Invalid Phone Number',
                                      desc: 'Please, Enter valid Phone Number',
                                    ).show(),
                                  }
                              }),
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

  void sendPhoneNumber() {
    final ap = Provider.of<BankAuthProvider>(context, listen: false);
    String phoneNumber = _phoneController.text.trim();
    ap.signInWithPhoneBank(context, "+91$phoneNumber");
  }
}
