import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/const_variable.dart';
import '../../../Modules/visibility_model.dart';
import '../../../provider/vendor_auth_provider.dart';
import '../../../who_are_you.dart';
import 'vendorForgotPassword.dart';
import 'vendor_signup.dart';

class VendorLogin extends StatefulWidget {
  const VendorLogin({Key? key}) : super(key: key);

  @override
  State<VendorLogin> createState() => _VendorLoginState();
}

class _VendorLoginState extends State<VendorLogin> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  bool validPhone = false;
  bool validPass = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WhoAreYou(),
              ),
            ),
            icon: Icon(
              CupertinoIcons.back,
              color: mainColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
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
                          image: AssetImage("assets/images/security_pin.png"),
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
                    // const SizedBox(height: 5.0),
                    // const Text(
                    //   textAlign: TextAlign.center,
                    //   "Add your phone number, we'll send you a verification code",
                    //   style: TextStyle(
                    //     color: Colors.black38,
                    //     fontWeight: FontWeight.bold,
                    //     letterSpacing: 1.0,
                    //   ),
                    // ),
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
                          controller: _usernameController,
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
                              CupertinoIcons.phone,
                              color: mainColor,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Consumer<VisibilityModel>(
                      builder: (context, myModel, child) {
                        return TextField(
                          obscureText: !myModel.isPassVisible,
                          onChanged: (val) => {
                            myModel.changePassValidation(val),
                            if (myModel.isPassValid)
                              {
                                validPass = true,
                              }
                            else
                              {
                                validPass = false,
                              }
                          },
                          controller: _passwordController,
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
                                color: myModel.isPassValid
                                    ? mainColor
                                    : Colors.red,
                                width: 1.5,
                              ),
                            ),
                            hintText: "Password",
                            suffixIcon: IconButton(
                              icon: myModel.isPassVisible
                                  ? const Icon(
                                      CupertinoIcons.eye,
                                    )
                                  : const Icon(
                                      CupertinoIcons.eye_slash,
                                    ),
                              onPressed: () => myModel.changePassVisibility(),
                              color: mainColor,
                            ),
                            prefixIcon: Icon(
                              CupertinoIcons.lock,
                              color: mainColor,
                            ),
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VendorForgotPassword()),
                          ),
                        },
                        child: const Text("forgot password?"),
                      ),
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
                                      title: 'Invalid Credential',
                                      desc: 'Please, Enter valid Credential',
                                    ).show(),
                                  }
                              }),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an Account?"),
                        const SizedBox(width: 2.0),
                        InkWell(
                          onTap: () => {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VendorSignUp(),
                              ),
                            ),
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    )
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
    final ap = Provider.of<VendorAuthProvider>(context, listen: false);
    String phoneNumber = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    ap.signInWithPhoneVendor(context, "+91$phoneNumber", password);
  }
}
