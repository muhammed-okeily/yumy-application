// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';
import 'package:food/screens/admin/ManageProduct.dart';
import 'package:food/screens/admin/addProduct.dart';
import 'package:food/screens/admin/ordersScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});
  static String id = 'AdminHomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kSecondaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text(
              'Add Product'.toUpperCase(),
              style: GoogleFonts.lato(fontSize: 21, color: kMainColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10),
              backgroundColor: kSecondaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, ManageProducts.id);
            },
            child: Text(
              'Edit Product'.toUpperCase(),
              style: GoogleFonts.lato(fontSize: 21, color: kMainColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kSecondaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, OrdersScreen.id);
            },
            child: Text(
              'View orders'.toUpperCase(),
              style: GoogleFonts.lato(fontSize: 21, color: kMainColor),
            ),
          )
        ],
      ),
    );
  }
}
