import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_it/User/Credential/user_login.dart';

import '../../Constant/const_variable.dart';
import '../../Modules/visibility_model.dart';

class UserForgotPassword extends StatefulWidget {
  const UserForgotPassword({super.key});

  @override
  State<UserForgotPassword> createState() => _UserForgotPasswordState();
}

class _UserForgotPasswordState extends State<UserForgotPassword> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  bool validEmail = false;
  bool validPass = false;
  bool validConfirmPass = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      "Forgot Password",
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
                                color: myModel.isEmailValid
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
                    const SizedBox(
                      height: 12.0,
                    ),
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
                              icon: myModel.isVisible
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () => myModel.changeVisibility(),
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
                    const SizedBox(height: 12.0),
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
                              Icons.lock,
                              color: mainColor,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
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
                                if (validPass && validEmail && validConfirmPass)
                                  {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const UserLogin()),
                                    )
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
                              }),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("back to "),
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
}
