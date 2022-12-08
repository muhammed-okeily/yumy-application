import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';

class HomeImage extends StatelessWidget {
  final String imagePath;
  const HomeImage({Key? key, required this.imagePath}) : super(key: key);

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
