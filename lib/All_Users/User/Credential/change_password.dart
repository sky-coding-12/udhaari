import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/user_spring_boot_model.dart';
import '../../../Modules/visibility_model.dart';
import '../../../services/api_calling.dart';
import 'user_login.dart';

class ChangePassword extends StatefulWidget {
  final String phone;
  const ChangePassword({Key? key, required this.phone}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late String phone;
  late Future<UserSpringBootModel> user;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  late bool validPass = false;
  late bool validConfirmPass = false;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    user = fetchUser(phone);
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backColor,
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
                          image:
                              AssetImage("assets/images/Forgot_password.png"),
                        ),
                      ),
                    ),
                    const Text(
                      "Change Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        fontSize: 22.0,
                      ),
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
                            hintText: "New Password",
                            suffixIcon: IconButton(
                              icon: myModel.isPassVisible
                                  ? const Icon(CupertinoIcons.eye)
                                  : const Icon(CupertinoIcons.eye_slash),
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
                    const SizedBox(height: 18.0),
                    FutureBuilder(
                      future: user,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.065,
                          child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromRGBO(63, 72, 204, 1))),
                              child: const Text(
                                "CHANGE PASSWORD",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              onPressed: () => {
                                    if (validPass && validConfirmPass)
                                      {
                                        updateUserPassword(
                                          phone,
                                          _passwordController.text,
                                          snapshot.data!.userName,
                                          snapshot.data!.totalDebit,
                                          snapshot.data!.totalCredit,
                                          snapshot.data!.creditScore,
                                          snapshot.data!.userId,
                                          snapshot.data!.securityPIN,
                                          snapshot.data!.email,
                                          snapshot.data!.image,
                                        )
                                            .then((value) => {
                                                  _firebaseFireStore
                                                      .collection("users")
                                                      .doc(
                                                          "+91${value.phoneNumber}")
                                                      .update({
                                                    "password": value.password,
                                                  })
                                                })
                                            .then((value) => {
                                                  AwesomeDialog(
                                                    context: context,
                                                    headerAnimationLoop: true,
                                                    animType: AnimType.scale,
                                                    btnCancelColor: mainColor,
                                                    dialogType:
                                                        DialogType.success,
                                                    btnOkOnPress: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const UserLogin(),
                                                        ),
                                                      );
                                                    },
                                                    btnOkColor: mainColor,
                                                    title: 'Success',
                                                    desc:
                                                        'Password Updated Successfully 😊',
                                                  ).show(),
                                                }),
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
                                          title: 'Invalid Password',
                                          desc: 'Please, enter valid password',
                                        ).show(),
                                      }
                                  }),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Back to "),
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
                            "Login",
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

  Future<UserSpringBootModel> updateUserPassword(
      String phone,
      String password,
      String? userName,
      int? totalDebit,
      int? totalCredit,
      int? creditScore,
      int? userId,
      String? securityPIN,
      String? email,
      String? image) async {
    final response = await http.put(
      Uri.https(baseUrl, "/user/updateUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userName': userName,
        'phoneNumber': phone,
        'email': email,
        'password': password,
        'totalCredit': totalCredit,
        'totalDebit': totalDebit,
        'creditScore': creditScore,
        'securityPIN': securityPIN,
        'image': image,
        'userId': userId
      }),
    );

    if (response.statusCode == 200) {
      return UserSpringBootModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user password.');
    }
  }
}
