import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final EdgeInsetsGeometry contentPadding;
  final Color backgroundColor;
  final Color borderColor;
  final BorderRadius borderRadius;
  final int MaxLines;
  final Widget? prefix;

  // Constructor to initialize parameters
  CustomTextField(
      {required this.hintText,
      required this.controller,
      this.keyboardType = TextInputType.text, // Default to text input
      this.obscureText = false, // Default to false (not obscured)
      this.contentPadding =
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      this.backgroundColor = const Color.fromARGB(185, 244, 243, 243),
      this.borderColor = Colors.grey, // Default to grey color for border
      this.borderRadius = const BorderRadius.all(Radius.circular(25.0)),
      this.MaxLines = 1,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: TextField(
        maxLines: MaxLines,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefix: prefix,
          prefixStyle: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
          hintText: hintText,
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(color: borderColor), // Custom border color
          ),
        ),
      ),
    );
  }
}
