import 'package:flutter/material.dart';
import 'package:take_it/Constant/const_variable.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final Icon prefixIcon;
  final IconButton? suffixIcon;
  final int? maxLength;
  final Function? onChanged;
  final Function validator;
  final Color? borderColor = Colors.red;
  final Color? errorColor;

  CustomTextField({
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.maxLength,
    this.onChanged,
    required this.validator,
    this.errorColor,
  });

  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late Color currentColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentColor = widget.borderColor!;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        if (widget.onChanged != null) {
          widget.onChanged!(text);
        }
        setState(() {
          if (!widget.validator(text) || text.isEmpty) {
            currentColor = Colors.red;
          } else {
            currentColor = mainColor;
          }
        });
      },
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
            color: currentColor,
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
