import 'package:flutter/material.dart';

import '../Constant/const_variable.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final Icon prefixIcon;
  final IconButton? suffixIcon;
  final int? maxLength;

  CustomTextField({
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.maxLength,
  });

  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      controller: widget.controller,
      maxLength: widget.maxLength,
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
            color: mainColor,
            width: 1.5,
          ),
        ),
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
