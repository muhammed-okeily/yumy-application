// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:animate_do/animate_do.dart';

import 'package:firebaseapis/firestore/v1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:food/providers/admin.dart';
import 'package:food/screens/signupSceen.dart';
import 'package:food/screens/user/HomeScreen.dart';
import 'package:food/widget/customTextField.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

import '../services/auth.dart';
import '../widget/customLogo.dart';
import 'admin/adminHomeScreen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool isAdmin = false;

  String? email, password;

  final adminPassword = 'admin123';

  bool keepMeLoggedIn = false;

  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: kMainColor,
        body: SingleChildScrollView(
          reverse: true,
          child: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return Form(
                  key: globalKey,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.95),
                    child: Column(children: [
                      Expanded(
                        flex: 10,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/person.jpg"),
                                fit: BoxFit.cover,
                                alignment: Alignment.bottomCenter),
                          ),
                        ),
                      ),
                      CustomLogo(),
                      CustomTextField(
                          onClick: (value) {
                            email = value;
                          },
                          hint: 'Enter your email ..',
                          icon: Icons.email_rounded),
                      SizedBox(
                        height: height * .03,
                      ),
                      CustomTextField(
                          onClick: (value) {
                            password = value;
                          },
                          hint: 'Enter your password ..',
                          icon: Icons.lock_clock_rounded),
                      SizedBox(
                        height: height * .03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.white),
                              child: Checkbox(
                                  checkColor: kSecondaryColor,
                                  activeColor: Colors.black,
                                  value: keepMeLoggedIn,
                                  onChanged: (value) {
                                    setState(() {
                                      keepMeLoggedIn = value!;
                                    });
                                  }),
                            ),
                            Text(
                              'Remmber Me',
                              style: TextStyle(color: kSecondaryColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                Provider.of<AdminMode>(context, listen: false)
                                    .changeIsAdmin(true);
                              },
                              child: Text(
                                'i\'m an admin',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color:
                                        Provider.of<AdminMode>(context).isAdmin
                                            ? kMainColor
                                            : Colors.white),
                              ),
                            )),
                            GestureDetector(
                              onTap: () {
                                Provider.of<AdminMode>(context, listen: false)
                                    .changeIsAdmin(false);
                              },
                              child: Expanded(
                                  child: Text(
                                'i\'m an user',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: Provider.of<AdminMode>(context,
                                                listen: true)
                                            .isAdmin
                                        ? Colors.white
                                        : kMainColor),
                              )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (keepMeLoggedIn == true) {
                                  keepUserLoggedIn();
                                }
                                Validate(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kSecondaryColor),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
              } else {
                return buildNoInternetWidget();
              }
            },
            child: showLoadingIndicator(),
          ),
        ));
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: kSecondaryColor,
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

  void Validate(BuildContext context) async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (password == adminPassword) {
          try {
            await auth.signIn(email!, password!);

            Navigator.pushNamed(context, AdminHomeScreen.id);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(e.toString()),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text('Somthing Went Wrong !'),
          ));
        }
      } else {
        try {
          await auth.signIn(email!, password!);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(e.toString()),
          ));
        }
      }
    }
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
