// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';
import 'package:food/services/store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../models/productModel.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store store = Store();
  @override
  Widget build(BuildContext context) {
    String? documentId = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      backgroundColor: kMainColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: store.loadOrderDetails(documentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data!.docs) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                products.add(Product(
                  pId: doc.id,
                  pName: data[kProductName],
                  pQuantity: data[kProductQuantity],
                  pPrice: data[kProductPrice],
                  pCategory: data[kProductCategory],
                ));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          color: kSecondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Product : ${products[index].pName.toString()}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Category : ${products[index].pCategory.toString()}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Quantitiy : ${products[index].pQuantity.toString()}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Price : \$${products[index].pPrice.toString()}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: products.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kSecondaryColor,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Confirm order'.toUpperCase(),
                              style: GoogleFonts.lato(
                                  fontSize: 10, color: kMainColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kSecondaryColor,
                            ),
                            onPressed: () {
                              store.deleteOrder(documentId);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'delete order'.toUpperCase(),
                              style: GoogleFonts.lato(
                                  fontSize: 10, color: kMainColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Lottie.network(
                  "https://assets7.lottiefiles.com/packages/lf20_kyi8qg4t.json",
                  fit: BoxFit.cover,
                ),
              );
            }
          }),
    );
  }
}
