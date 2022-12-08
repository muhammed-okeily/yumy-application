// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';

class ProductView extends StatelessWidget {
  final String imagePath;
  const ProductView({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      width: size.width,
      decoration: BoxDecoration(
        color: kMainColor,
        image: DecorationImage(
          image: AssetImage(
            imagePath,
          ),
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kSecondaryColor,
            blurRadius: 5,
            spreadRadius: 6,
            offset: Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
