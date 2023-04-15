import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/user_model.dart';
import '../../../Modules/visibility_model.dart';
import '../../../provider/user_auth_provider.dart';
import '../../../utils/utils.dart';
import '../Screens/user_dashboard.dart';
import 'user_login.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  File? image;

  late TextEditingController _usernameController;
  late TextEditingController _mobileController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _emailController;
  late TextEditingController _pinController;
  late TextEditingController _confirmPinController;

  bool validUsername = false;
  bool validPhone = false;
  bool validEmail = false;
  bool validPass = false;
  bool validConfirmPass = false;
  bool validPIN = false;
  bool validConfirmPIN = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _mobileController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _emailController = TextEditingController();
    _pinController = TextEditingController();
    _confirmPinController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
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
        body: SafeArea(
          child: ChangeNotifierProvider<VisibilityModel>(
            create: (context) => VisibilityModel(),
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      // const Text(
                      //   "SIGNUP",
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     letterSpacing: 1.0,
                      //     fontSize: 22.0,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      InkWell(
                        onTap: () => selectImage(),
                        child: image == null
                            ? CircleAvatar(
                                backgroundColor: mainColor,
                                radius: 50,
                                child: const Icon(
                                  CupertinoIcons.photo,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(image!),
                                radius: 50,
                              ),
                      ),
                      const SizedBox(height: 10),
                      Consumer<VisibilityModel>(
                        builder: (context, myModel, child) {
                          return TextField(
                            onChanged: (val) => {
                              myModel.changeUsernameValidation(val),
                              if (myModel.isUsernameValid)
                                {
                                  validUsername = true,
                                }
                              else
                                {
                                  validUsername = false,
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
                                  color: myModel.isUsernameValid
                                      ? mainColor
                                      : Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              hintText: "Username",
                              prefixIcon: Icon(
                                CupertinoIcons.person,
                                color: mainColor,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15.0),
                      Consumer<VisibilityModel>(
                        builder: (context, myModel, child) {
                          return TextField(
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
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
                            controller: _mobileController,
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
                              hintText: "Mobile Number",
                              prefixIcon: Icon(
                                CupertinoIcons.phone,
                                color: mainColor,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15.0),
                      Consumer<VisibilityModel>(
                        builder: (context, myModel, child) {
                          return TextField(
                            onChanged: (val) => {
                              myModel.changeEmailValidation(val),
                              if (myModel.isEmailValid)
                                {
                                  validEmail = true,
                                }
                              else
                                {
                                  validEmail = false,
                                }
                            },
                            controller: _emailController,
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
                                  color: myModel.isEmailValid
                                      ? mainColor
                                      : Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              hintText: "Email Address",
                              prefixIcon: Icon(
                                CupertinoIcons.mail,
                                color: mainColor,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15.0),
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
                                    ? const Icon(CupertinoIcons.eye)
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
                      const SizedBox(height: 15.0),
                      Consumer<VisibilityModel>(
                        builder: (context, myModel, child) {
                          return TextField(
                            obscureText: true,
                            onChanged: (val) => {
                              myModel.changeConfirmPassValidation(
                                  _passwordController.text, val),
                              if (myModel.isConfirmValid)
                                {
                                  validConfirmPass = true,
                                }
                              else
                                {
                                  validConfirmPass = false,
                                }
                            },
                            controller: _confirmPasswordController,
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
                                  color: myModel.isConfirmValid
                                      ? mainColor
                                      : Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              hintText: "Confirm Password",
                              prefixIcon: Icon(
                                CupertinoIcons.lock,
                                color: mainColor,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12.0),
                      Consumer<VisibilityModel>(
                        builder: (context, myModel, child) {
                          return TextField(
                            obscureText: !myModel.isPinVisible,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            onChanged: (val) => {
                              myModel.changePINValidation(val),
                              if (myModel.isPINValid)
                                {
                                  validPIN = true,
                                }
                              else
                                {
                                  validPIN = false,
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
                                  color: myModel.isPINValid
                                      ? mainColor
                                      : Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: myModel.isPinVisible
                                    ? const Icon(
                                        CupertinoIcons.eye,
                                      )
                                    : const Icon(
                                        CupertinoIcons.eye_slash,
                                      ),
                                onPressed: () => myModel.changePinVisibility(),
                                color: mainColor,
                              ),
                              hintText: "Security PIN (4 digit)",
                              prefixIcon: Icon(
                                CupertinoIcons.number,
                                color: mainColor,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12.0),
                      Consumer<VisibilityModel>(
                        builder: (context, myModel, child) {
                          return TextField(
                            obscureText: true,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            onChanged: (val) => {
                              myModel.changeConfirmPINValidation(
                                  _pinController.text, val),
                              if (myModel.isConfirmPINValid)
                                {
                                  validConfirmPIN = true,
                                }
                              else
                                {
                                  validConfirmPIN = false,
                                }
                            },
                            controller: _confirmPinController,
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
                                  color: myModel.isConfirmPINValid
                                      ? mainColor
                                      : Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              hintText: "Confirm Security PIN",
                              prefixIcon: Icon(
                                CupertinoIcons.number,
                                color: mainColor,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.065,
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromRGBO(63, 72, 204, 1))),
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            onPressed: () {
                              if (validConfirmPass &&
                                  validPhone &&
                                  validPass &&
                                  validEmail &&
                                  validPhone &&
                                  validPIN &&
                                  validConfirmPIN &&
                                  validUsername) {
                                storeData();
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  headerAnimationLoop: true,
                                  animType: AnimType.scale,
                                  btnCancelColor: mainColor,
                                  dialogType: DialogType.error,
                                  btnCancelOnPress: () {},
                                  title: 'Invalid Details',
                                  desc: 'Please, enter valid details',
                                ).show();
                              }
                            }),
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an Account?"),
                          const SizedBox(width: 2.0),
                          InkWell(
                            onTap: () => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserLogin(),
                                ),
                              ),
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<UserAuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "+91${_mobileController.text.trim()}",
      uid: "",
      securityPIN: _pinController.text.trim(),
    );
    if (image != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        name: _usernameController.text.trim(),
        phone: _mobileController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        pin: _pinController.text.trim(),
        profilePic: image!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setUserSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserDashboard(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {
      AwesomeDialog(
        context: context,
        headerAnimationLoop: true,
        animType: AnimType.scale,
        btnCancelColor: mainColor,
        dialogType: DialogType.error,
        btnCancelOnPress: () {},
        title: 'Profile Photo Missing',
        desc: 'Please upload your profile photo',
      ).show();
    }
  }
}
