// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';
import 'package:food/screens/user/widget/homeimage.dart';

import 'package:lottie/lottie.dart';

import '../../../constants/functions.dart';
import '../../../models/productModel.dart';
import '../productInfo.dart';

Widget ProductViewAllProduct(String pCategory, List<Product> allproducts) {
  List<Product> products;
  products = getProductByCategory(pCategory, allproducts);
  if (products.isNotEmpty) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 350,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemBuilder: (context, index) => Container(
        color: kMainColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductInfo.id,
                  arguments: products[index]);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kSecondaryColor,
                  boxShadow: const [
                    BoxShadow(
                      color: kSecondaryColor,
                      blurRadius: 5,
                      spreadRadius: 6,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    FadeInDown(
                        child: HomeImage(
                            imagePath: products[index].pLocation.toString())),
                    Positioned(
                      bottom: 0.0,
                      left: 10,
                      right: 10,
                      child: Opacity(
                        opacity: 0.75,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          color: kMainColor,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                products[index].pName.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kSecondaryColor),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '\$ ${products[index].pPrice.toString()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kSecondaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      itemCount: products.length,
    );
  } else {
    return Center(
      child: Lottie.network(
        "https://assets6.lottiefiles.com/private_files/lf30_cjoryulu.json",
        fit: BoxFit.cover,
      ),
    );
  }
}
