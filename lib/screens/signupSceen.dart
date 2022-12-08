// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:animate_do/animate_do.dart';

import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food/constants/constants.dart';
import 'package:food/screens/LoginScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/UserModel.dart';
import '../providers/modelhud.dart';
import '../services/auth.dart';
import '../widget/customLogo.dart';
import '../widget/customTextField.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  static String id = 'SignUpScreen';
  String? email, password, name, phone;
  final auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ProgressHUD(
        child: Form(
          key: globalKey,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.95),
            child: Column(
              children: [
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
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Expanded(
                        flex: 2,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("SIGN UP",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, LoginScreen.id);
                                    },
                                    child: Text("SIGN IN",
                                        style: TextStyle(
                                            color: kSecondaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ])))),
                CustomTextField(
                    onClick: (value) {
                      name = value;
                    },
                    hint: 'Enter your name ..',
                    icon: Icons.person_sharp),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                    onClick: (value) {
                      email = value;
                    },
                    hint: 'Enter your email ..',
                    icon: Icons.email_rounded),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                    onClick: (value) {
                      phone = value;
                    },
                    hint: 'Enter your phone ..',
                    icon: Icons.phone_android),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                    onClick: (value) {
                      password = value;
                    },
                    hint: 'Enter your password ..',
                    icon: Icons.lock_clock_rounded),
                SizedBox(
                  height: height * .04,
                ),
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                           final modelhud =
                          Provider.of<ModelHud>(context, listen: false);
                      modelhud.changeisLoading(true);
                      if (globalKey.currentState!.validate()) {
                        globalKey.currentState?.save();
                        try {
                          final authResult = await auth.signUp(
                              email!.trim(), password!.trim());

                          auth.addUser(Users(
                              uName: name, uPhone: phone, uEmail: email, uPassword: password));
                          modelhud.changeisLoading(false);
                          Navigator.pushNamed(context, LoginScreen.id);
                        } catch (e) {
                          modelhud.changeisLoading(false);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(e.toString()),
                          ));
                        }
                      }
                      modelhud.changeisLoading(false);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: kSecondaryColor),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
