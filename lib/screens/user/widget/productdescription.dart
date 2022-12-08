// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDesc extends StatelessWidget {
  final String description;
  const ProductDesc({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Description ",
              style: TextStyle(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: 2),
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
                color: kSecondaryColor),
          )
        ],
      ),
    );
  }
}
