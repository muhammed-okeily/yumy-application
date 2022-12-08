import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductTitle extends StatelessWidget {
  final String title;
  const ProductTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3),
            ),
          ],
        ),
      ),
    );
  }
}
