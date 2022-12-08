import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';
import 'package:food/providers/admin.dart';
import 'package:food/providers/cartItem.dart';
import 'package:food/providers/modelhud.dart';
import 'package:food/screens/LoginScreen.dart';
import 'package:food/screens/OnBoarding.dart';
import 'package:food/screens/admin/addProduct.dart';
import 'package:food/screens/admin/orderdetails.dart';
import 'package:food/screens/signupSceen.dart';
import 'package:food/screens/user/HomeScreen.dart';
import 'package:food/screens/user/productInfo.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/cash_helper.dart';
import 'screens/admin/EditProduct.dart';
import 'screens/admin/ManageProduct.dart';
import 'screens/admin/adminHomeScreen.dart';
import 'screens/admin/ordersScreen.dart';
import 'screens/user/cartScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();
  bool onBoarding = CashHelper.getData(key: 'onBoarding');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;
  bool onBoarding = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                child: Lottie.network(
                  "https://assets7.lottiefiles.com/packages/lf20_kyi8qg4t.json",
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            isUserLoggedIn = snapshot.data?.getBool(kKeepMeLoggedIn) ?? false;
            onBoarding = snapshot.data?.getBool(kOnboarding) ?? false;

            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModelHud>(
                  create: (context) => ModelHud(),
                ),
                ChangeNotifierProvider<CartItem>(
                  create: (context) => CartItem(),
                ),
                ChangeNotifierProvider<AdminMode>(
                  create: (context) => AdminMode(),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: isUserLoggedIn ? HomeScreen.id : OnBoarding.id,
                routes: {
                  OnBoarding.id: (context) => OnBoarding(),
                  LoginScreen.id: (context) => LoginScreen(),
                  SignUpScreen.id: (context) => SignUpScreen(),
                  AdminHomeScreen.id: (context) => AdminHomeScreen(),
                  AddProduct.id: (context) => AddProduct(),
                  ManageProducts.id: (context) => ManageProducts(),
                  OrdersScreen.id: (context) => OrdersScreen(),
                  EditProduct.id: (context) => EditProduct(),
                  HomeScreen.id: (context) => HomeScreen(),
                  ProductInfo.id: (context) => ProductInfo(),
                  CartScreen.id: (context) => CartScreen(),
                  OrderDetails.id: (context) => OrderDetails(),
                },
              ),
            );
          }
        });
  }
}
