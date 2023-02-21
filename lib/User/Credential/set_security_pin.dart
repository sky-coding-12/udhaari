import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constant/const_variable.dart';
import '../../Modules/visibility_model.dart';

class SetSecurityPIN extends StatefulWidget {
  const SetSecurityPIN({Key? key}) : super(key: key);

  @override
  State<SetSecurityPIN> createState() => _SetSecurityPINState();
}

class _SetSecurityPINState extends State<SetSecurityPIN> {
  late TextEditingController _pinController;
  late TextEditingController _confirmPinController;

  bool validPIN = false;
  bool validConfirmPIN = false;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
    _confirmPinController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
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
                          image: AssetImage("assets/images/security_pin.png"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      "Set Security PIN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Consumer<VisibilityModel>(
                      builder: (context, myModel, child) {
                        return TextField(
                          obscureText: !myModel.isVisible,
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
                                color:
                                    myModel.isPINValid ? mainColor : Colors.red,
                                width: 1.5,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: myModel.isVisible
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () => myModel.changeVisibility(),
                              color: mainColor,
                            ),
                            hintText: "Security PIN (4 digit)",
                            prefixIcon: Icon(
                              Icons.pin,
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
                              Icons.pin,
                              color: mainColor,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.065,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromRGBO(63, 72, 204, 1))),
                          child: const Text(
                            "LOG IN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onPressed: () => {
                                if (validPIN && validConfirmPIN)
                                  {}
                                else
                                  {
                                    AwesomeDialog(
                                      context: context,
                                      headerAnimationLoop: true,
                                      animType: AnimType.scale,
                                      btnCancelColor: mainColor,
                                      dialogType: DialogType.error,
                                      btnCancelOnPress: () {},
                                      title: 'Invalid Security PIN',
                                      desc: 'Confirm PIN is not match',
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
}
