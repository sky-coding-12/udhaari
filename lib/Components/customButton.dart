import 'package:flutter/material.dart';

import '../Constant/const_variable.dart';

class CustomButton extends StatelessWidget {
  String btnText;

  CustomButton({
    Key? key,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.065,
      child: Container(
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Center(
          child: Text(
            btnText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
