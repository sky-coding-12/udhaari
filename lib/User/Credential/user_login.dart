import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Components/customButton.dart';
import '../../Components/customTextField.dart';
import '../../Constant/const_variable.dart';
import '../../Modules/visibility_model.dart';
import '../../otp_verification.dart';
import 'userForgotPassword.dart';
import 'user_signup.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

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
                      "LOGIN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    CustomTextField(
                      hint: "Username",
                      controller: _usernameController,
                      prefixIcon: Icon(
                        Icons.person,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserForgotPassword()),
                          ),
                        },
                        child: const Text("forgot password?"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (builder) => const OtpVerification()),
                      ),
                      child: CustomButton(
                        btnText: "LOGIN",
                      ),
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
                                builder: (context) => const UserSignUp(),
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
}
