import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    this.controller,
    this.obscureText = false,
    this.hintText = 'Default Hint Text'
  }) : super(key: key);

  final TextEditingController? controller;
  final bool obscureText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}