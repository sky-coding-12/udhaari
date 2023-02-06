import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Components/customButton.dart';
import 'Components/customTextField.dart';
import 'Constant/const_variable.dart';
import 'Modules/visibility_model.dart';

class SetSecurityPIN extends StatefulWidget {
  const SetSecurityPIN({Key? key}) : super(key: key);

  @override
  State<SetSecurityPIN> createState() => _SetSecurityPINState();
}

class _SetSecurityPINState extends State<SetSecurityPIN> {
  late TextEditingController _pinController;
  late TextEditingController _confirmPinController;

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
                        return CustomTextField(
                          inputType: TextInputType.number,
                          hint: "Security PIN (4 digit)",
                          controller: _pinController,
                          obscureText: !myModel.isVisible,
                          maxLength: 4,
                          prefixIcon: Icon(
                            Icons.pin,
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
                      },
                    ),
                    const SizedBox(height: 12.0),
                    Consumer<VisibilityModel>(
                      builder: (context, myModel, child) {
                        return CustomTextField(
                          inputType: TextInputType.number,
                          hint: "Confirm Security PIN",
                          obscureText: true,
                          controller: _confirmPinController,
                          maxLength: 4,
                          prefixIcon: Icon(
                            Icons.pin,
                            color: mainColor,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12.0),
                    GestureDetector(
                      onTap: () => {},
                      child: CustomButton(
                        btnText: "CONFIRM PIN",
                      ),
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
