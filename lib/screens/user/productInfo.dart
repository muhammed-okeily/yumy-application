// ignore_for_file: avoid_print, prefer_const_constructors, avoid_single_cascade_in_expression_statements

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food/constants/constants.dart';
import 'package:food/providers/cartItem.dart';
import 'package:food/screens/user/widget/productAppBar.dart';
import 'package:food/screens/user/widget/productColor.dart';
import 'package:food/screens/user/widget/productImage.dart';
import 'package:food/screens/user/widget/productPrice.dart';
import 'package:food/screens/user/widget/productTitle.dart';
import 'package:food/screens/user/widget/productdescription.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/productModel.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key});
  static String id = 'ProductInfo';
  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  var _quantity = 1;
  // ignore: non_constant_identifier_names
  String KeepUserDataInCart = '';
  @override
  Widget build(BuildContext context) {
    Product? product = ModalRoute.of(context)?.settings.arguments as Product;

    return Scaffold(
      /// this is product page's appbar.
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ProductAppBar(
          title: 'details'.toUpperCase(),
        ),
      ),
      body: Container(
        color: kMainColor,
        child: Padding(
          padding: EdgeInsets.only(left: 18, right: 18, top: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// top image of product
              FadeInDown(child: ProductView(imagePath: product.pLocation!)),
              SizedBox(
                height: 20,
              ),

              /// this is for product name.
              FadeInLeft(
                  child: ProductTitle(
                title: product.pName!,
              )),
              SizedBox(
                height: 20,
              ),

              /// this is for ratings
              FadeInRight(
                  child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      unratedColor: kSecondaryColor,
                      itemSize: 20,
                      itemBuilder: (context, _) => const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: subtract,
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 20, right: 5, left: 5),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: kSecondaryColor),
                            child: const Icon(
                              Icons.minimize_outlined,
                              size: 25,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _quantity.toString(),
                          style: TextStyle(
                              color: kSecondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: add,
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, right: 5, left: 5),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: kSecondaryColor),
                            child: const Icon(
                              Icons.add,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),

              /// this is for product ratings
              SizedBox(
                height: 20,
              ),

              FadeInLeft(
                child: ProductDesc(description: product.pDescription!),
              ),

              /// this is for adjust product size.

              /// this is for choosing product color.

              /// this will push add to cart button little bit down.
              const Spacer(),

              /// this is the button for buying products.
              Builder(
                builder: (context) => FadeInDown(
                    child: ProductBuy(
                  price: '\$${product.pPrice!}',
                  onTap: () async {
                    addToCard(context, product);
                  },
                )),
              ),

              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }

  void addToCard(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productInCart = cartItem.products;
    for (var productInCart in productInCart) {
      if (productInCart == product) {
        exist = true;
      }
    }
    if (exist) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 600),
        content: Text('you\'ve added this item before'.toUpperCase()),
      ));
    } else {
      cartItem.addProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 600),
        content: Text('Added to Cart'.toUpperCase()),
      ));
    }
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
    });
  }
}
