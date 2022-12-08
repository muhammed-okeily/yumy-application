// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';
import 'package:food/screens/admin/orderdetails.dart';
import 'package:food/services/store.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/orderModel.dart';

class OrdersScreen extends StatelessWidget {
  static String id = 'OrdersScreen';
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kMainColor,
        body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadOrders(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('There is no orders here.'),
              );
            } else {
              List<Orders> orders = [];
              for (var doc in snapshot.data!.docs) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                orders.add(Orders(
                    documentId: doc.id,
                    totalePrice: data[kTotalePrice],
                    address: data[kAddress],
                    phone: data[kPhone],
                    name: data[kName],
                    dateTimeNow: data[kDate]?.toDate()));
              }

              return ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OrderDetails.id,
                          arguments: orders[index].documentId);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .25,
                      color: kSecondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Totale Price = \$${orders[index].totalePrice.toString()}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2)),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Name : ${orders[index].name.toString()}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Phone number : ${orders[index].phone.toString()}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Adress : ${orders[index].address.toString()}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Date of Order : ${orders[index].dateTimeNow.toString().substring(0, 10)}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                itemCount: orders.length,
              );
            }
          },
        ));
  }
}
