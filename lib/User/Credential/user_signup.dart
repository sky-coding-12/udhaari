import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Components/customButton.dart';
import '../../Components/customTextField.dart';
import '../../Constant/const_variable.dart';
import '../../Modules/visibility_model.dart';
import '../../set_security_pin.dart';
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
          "CredMate",
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
                    CustomTextField(
                      hint: "Username",
                      controller: _usernameController,
                      prefixIcon: Icon(
                        Icons.person,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    CustomTextField(
                      hint: "Mobile Number",
                      controller: _mobileController,
                      inputType: TextInputType.phone,
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    CustomTextField(
                      hint: "Email Address",
                      controller: _emailController,
                      inputType: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Consumer<VisibilityModel>(
                        builder: (context, myModel, child) {
                      return CustomTextField(
                        hint: "Password",
                        obscureText: !myModel.isVisible,
                        controller: _passwordController,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: mainColor,
                        ),
                        suffixIcon: IconButton(
                          icon: myModel.isVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () => myModel.changeVisibility(),
                          color: mainColor,
                        ),
                      );
                    }),
                    const SizedBox(height: 15.0),
                    CustomTextField(
                      hint: "Confirm Password",
                      obscureText: true,
                      controller: _confirmPasswordController,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetSecurityPIN(),
                        ),
                      ),
                      child: CustomButton(
                        btnText: "SIGNUP",
                        btnWidth: MediaQuery.of(context).size.width,
                      ),
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
