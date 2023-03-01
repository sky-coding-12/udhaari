import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_it/User/Screens/user_dashboard.dart';

import '../../Constant/const_variable.dart';
import '../../Models/user_model.dart';
import '../../Modules/visibility_model.dart';
import '../../provider/auth_provider.dart';
import '../../utils/utils.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  File? image;

  late TextEditingController _usernameController;
  late TextEditingController _mobileController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _emailController;

  bool validUsername = false;
  bool validPhone = false;
  bool validEmail = false;
  bool validPass = false;
  bool validConfirmPass = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _mobileController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              )
            : ChangeNotifierProvider<VisibilityModel>(
                create: (context) => VisibilityModel(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 5.0),
                  child: Center(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => selectImage(),
                          child: image == null
                              ? CircleAvatar(
                                  backgroundColor: mainColor,
                                  radius: 70,
                                  child: const Icon(
                                    Icons.image,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(image!),
                                  radius: 70,
                                ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              // name field
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 22.0,
                                        vertical: 12.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: myModel.isUsernameValid
                                              ? mainColor
                                              : Colors.red,
                                          width: 1.5,
                                        ),
                                      ),
                                      hintText: "Username",
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: mainColor,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 15.0),

                              // email
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 22.0,
                                        vertical: 12.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: myModel.isEmailValid
                                              ? mainColor
                                              : Colors.red,
                                          width: 1.5,
                                        ),
                                      ),
                                      hintText: "Email Address",
                                      prefixIcon: Icon(
                                        Icons.alternate_email,
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
                                    obscureText: !myModel.isVisible,
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 22.0,
                                        vertical: 12.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: myModel.isPassValid
                                              ? mainColor
                                              : Colors.red,
                                          width: 1.5,
                                        ),
                                      ),
                                      hintText: "Password",
                                      suffixIcon: IconButton(
                                        icon: myModel.isVisible
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                        onPressed: () =>
                                            myModel.changeVisibility(),
                                        color: mainColor,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 22.0,
                                        vertical: 12.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: myModel.isConfirmValid
                                              ? mainColor
                                              : Colors.red,
                                          width: 1.5,
                                        ),
                                      ),
                                      hintText: "Confirm Password",
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: mainColor,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.065,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromRGBO(63, 72, 204, 1))),
                            child: Text("Continue"),
                            onPressed: () => {
                              if (validUsername &&
                                  validEmail &&
                                  validPass &&
                                  validConfirmPass)
                                {
                                  storeData(),
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
                                    title: 'Invalid Details',
                                    desc: 'Please, enter valid details',
                                  ).show(),
                                }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
    );
    if (image != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
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
