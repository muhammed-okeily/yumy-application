// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductColor extends StatelessWidget {
  const ProductColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Colors ",
            style: GoogleFonts.lobster(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 2),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              colorWidget(Colors.red),
              const SizedBox(
                width: 15,
              ),
              colorWidget(Colors.green),
              const SizedBox(
                width: 15,
              ),
              colorWidget(Colors.blue),
              const SizedBox(
                width: 15,
              ),
              colorWidget(Colors.purple),
              const SizedBox(
                width: 15,
              ),
              colorWidget(Colors.yellow),
            ],
          ),
        ],
      ),
    );
  }

  Widget colorWidget(Color color) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 10,
    );
  }
}
