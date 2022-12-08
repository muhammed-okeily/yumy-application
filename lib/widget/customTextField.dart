// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final Function(String?)? onClick;
  String? errorMsg(String str) {
    switch (hint) {
      case 'Enter your name ..':
        return 'Name is empty !';
      case 'Enter your email ..':
        return 'Email is empty !';
      case 'Enter your phone ..':
        return 'Email is empty !';
      case 'Enter your password ..':
        return 'Password is empty !';
    }
  }

  const CustomTextField(
      {super.key, required this.hint, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextFormField(
          style: TextStyle(
            color: Colors.white,
          ),
          validator: ((value) {
            if (value!.isEmpty) {
              return errorMsg(hint);
            }
          }),
          onSaved: onClick,
          obscureText: hint == 'Enter your password ..' ? true : false,
          cursorColor: kSecondaryColor,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kSecondaryColor),
            ),
            hintText: hint,
            hintStyle: TextStyle(color: kSecondaryColor),
            prefixIcon: Icon(
              icon,
              color: kSecondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

Widget defaultTextButton({
  required function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: kSecondaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
