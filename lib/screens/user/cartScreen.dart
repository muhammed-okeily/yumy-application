// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';
import 'package:food/screens/user/productInfo.dart';
import 'package:food/services/store.dart';
import 'package:food/widget/customPopMenu.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../models/productModel.dart';
import '../../providers/cartItem.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static String id = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: kMainColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        title: Text(
          'My Cart',
          style: TextStyle(color: kSecondaryColor, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: kSecondaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          LayoutBuilder(builder: (context, constrains) {
            if (products.isNotEmpty) {
              return Container(
                height: screenHeight -
                    statusBarHeight -
                    appBarHeight -
                    (screenHeight * .08),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTapUp: (details) {
                          showCustomMenu(details, context, products[index]);
                        },
                        child: Container(
                          height: screenHeight * .15,
                          color: kSecondaryColor,
                          child: Row(
                            children: [
                              Container(
                                child: FadeInDown(
                                  child: CircleAvatar(
                                    radius: screenHeight * 0.15 / 2,
                                    backgroundImage: AssetImage(
                                        products[index].pLocation.toString()),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FadeInRight(
                                            child: Text(
                                              products[index].pName.toString(),
                                              style: TextStyle(
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.w700,
                                                  color: kMainColor),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '\$ ',
                                                style: TextStyle(
                                                    color: kMainColor,
                                                    fontSize: 16),
                                              ),
                                              FadeInLeft(
                                                child: Text(
                                                  products[index]
                                                      .pPrice
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: kMainColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: FadeInDown(
                                          child: Text(
                                            'x${products[index].pQuantity.toString()}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: kMainColor),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              );
            } else {
              return Container(
                  color: kMainColor,
                  height: screenHeight -
                      statusBarHeight -
                      appBarHeight -
                      (screenHeight * .08),
                  child: Center(
                      child: Text(
                    'cart is empty'.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kSecondaryColor),
                  )));
            }
          }),
          Container(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, right: 40, left: 40),
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: GestureDetector(
              onTap: () {
                showCustomDialog(products, context);
              },
              child: Text(
                "order".toUpperCase(),
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: kMainColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void showCustomMenu(details, context, product) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;
    await showMenu(
        color: Colors.black,
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          MyPopupMenuItem(
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
              Navigator.pushNamed(context, ProductInfo.id, arguments: product);
            },
            child: Text(
              'Edit',
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          MyPopupMenuItem(
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ]);
  }

  void showCustomDialog(List<Product> products, context) async {
    DateTime dateNow = DateTime.now();
    var price = getTotallPrice(products);
    var address;
    var phone;
    var name;

    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.white,
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            try {
              Store _store = Store();
              _store.storeOrders({
                kTotalePrice: price,
                kAddress: address,
                kPhone: phone,
                kName: name,
                kDate: dateNow
              }, products);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Orderd Successfully'),
              ));
              Navigator.pop(context);
            } catch (ex) {
              print(ex.toString());
            }
          },
          child: Text('Confirm'.toUpperCase(),
              style: GoogleFonts.lato(color: kSecondaryColor)),
        )
      ],
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            TextField(
              onChanged: (value) {
                address = value;
              },
              decoration: InputDecoration(
                  hintText: 'Enter your Address', hintStyle: TextStyle()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: phone,
              keyboardAppearance: phone,
              onChanged: (value) {
                phone = value;
              },
              decoration: InputDecoration(
                  hintText: 'Enter your phone number', hintStyle: TextStyle()),
            ),
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(
                  hintText: 'Enter your name', hintStyle: TextStyle()),
            ),
          ],
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Totale Price  = \$$price'.toUpperCase(),
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat.yMMMEd().format(dateNow),
                style: TextStyle(fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotallPrice(List<Product> products) {
    int price = 0;
    for (var product in products) {
      price += product.pQuantity! * int.parse(product.pPrice!);
    }
    return price;
  }

  datetimeNowHere(DateTime) {}
}
