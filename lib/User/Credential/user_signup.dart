import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constant/const_variable.dart';
import '../../Modules/visibility_model.dart';
import 'set_security_pin.dart';
import 'user_login.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
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
      body: ChangeNotifierProvider<VisibilityModel>(
        create: (context) => VisibilityModel(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                    const Text(
                      "SIGNUP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
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
                              Icons.person,
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
                              Icons.phone_android,
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
                              Icons.lock,
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
                                validPhone) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SetSecurityPIN(),
                                ),
                              );
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
                    const Text(
                      "OR",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => print("facebook"),
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/facebook.png"),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 25.0),
                        GestureDetector(
                          onTap: () => print("google"),
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/google.png"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
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
