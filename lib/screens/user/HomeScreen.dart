// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:food/constants/constants.dart';
import 'package:food/screens/user/productInfo.dart';
import 'package:food/screens/user/widget/ProductViewallProducts.dart';
import 'package:food/screens/user/widget/homeimage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/functions.dart';
import '../../models/productModel.dart';
import '../../services/auth.dart';
import '../../services/store.dart';
import '../LoginScreen.dart';
import 'cartScreen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = Auth();
  int tabBarIndex = 0;
  int bottomBarIndex = 0;
  final store = Store();
  List<Product> _products = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 3,
          child: Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                  animationCurve: Curves.easeOutSine,
                  height: 45,
                  backgroundColor: kSecondaryColor,
                  index: bottomBarIndex,
                  color: kMainColor,
                  onTap: (value) async {
                    if (value == 1) {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.clear();
                      await auth.signOut();
                      Navigator.popAndPushNamed(context, LoginScreen.id);
                    }

                    if (value == 0) {
                      Navigator.pushNamed(context, HomeScreen.id);
                    }

                    setState(() {
                      bottomBarIndex = value;
                    });
                  },
                  items: [
                    Icon(
                      Icons.home,
                      color: kSecondaryColor,
                    ),
                    Icon(
                      Icons.exit_to_app_outlined,
                      color: kSecondaryColor,
                    )
                  ]),
              appBar: AppBar(
                backgroundColor: kMainColor,
                elevation: 10,
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: kSecondaryColor,
                  onTap: (value) {
                    setState(() {
                      tabBarIndex = value;
                    });
                  },
                  tabs: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(13),
                        ),
                        color: kMainColor,
                      ),
                      child: Text(
                        'Food',
                        style: TextStyle(
                          color:
                              tabBarIndex == 0 ? kSecondaryColor : Colors.white,
                          fontSize: tabBarIndex == 0 ? 24 : 12,
                          fontWeight: tabBarIndex == 0 ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(13),
                        ),
                        color: kMainColor,
                      ),
                      child: Text(
                        'Drink',
                        style: TextStyle(
                          color:
                              tabBarIndex == 1 ? kSecondaryColor : Colors.white,
                          fontSize: tabBarIndex == 1 ? 24 : 12,
                          fontWeight: tabBarIndex == 1 ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(13),
                        ),
                        color: kMainColor,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Offers',
                            style: TextStyle(
                              color: tabBarIndex == 2
                                  ? kSecondaryColor
                                  : Colors.white,
                              fontSize: tabBarIndex == 2 ? 24 : 12,
                              fontWeight:
                                  tabBarIndex == 2 ? FontWeight.bold : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: OfflineBuilder(
                connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                ) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  if (connected) {
                    return Container(
                      color: kMainColor,
                      child: TabBarView(
                        children: [
                          FoodView(),
                          ProductViewAllProduct(kDrink, _products),
                          ProductViewAllProduct(kOffers, _products),
                        ],
                      ),
                    );
                  } else {
                    return buildNoInternetWidget();
                  }
                },
                child: showLoadingIndicator(),
              )),
        ),
        Material(
          color: kMainColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'More food more health'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Icon(
                        Icons.shopping_cart,
                        color: kSecondaryColor,
                      ))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrenUser();
  }

  getCurrenUser() async {
    auth.getUser().toString();
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: kMainColor,
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 350,
            ),
            Text(
              'Can\'t connect .. check internet',
              style: TextStyle(
                  fontSize: 16, color: kMainColor, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/images/nointernet.gif',
            ),
            SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }

  Widget FoodView() {
    return StreamBuilder<QuerySnapshot>(
        stream: store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product>? products = [];
            for (var doc in snapshot.data!.docs) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

              products.add(Product(
                  pId: doc.id,
                  pPrice: data[kProductPrice],
                  pName: data[kProductName],
                  pDescription: data[kProductDescription],
                  pLocation: data[kProductLocation],
                  pCategory: data[kProductCategory]));
            }
            _products = [...products];
            products.clear();
            products = getProductByCategory(kFood, _products);
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ProductInfo.id,
                          arguments: products![index]);
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
                                    imagePath:
                                        products![index].pLocation.toString())),
                            Positioned(
                              bottom: 0.0,
                              left: 10,
                              right: 10,
                              child: Opacity(
                                opacity: 0.75,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 40,
                                  color: kMainColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        products[index].pName.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: kSecondaryColor),
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
                  width: 70,
                  fit: BoxFit.cover,
                  height: 70),
            );
          }
        });
  }
}
