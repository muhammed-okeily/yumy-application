// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';
import 'package:food/screens/LoginScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/cash_helper.dart';
import '../widget/customTextField.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.body, required this.title, required this.image});
}

class OnBoarding extends StatefulWidget {
  static String id = 'OnBoarding';
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        body: 'healthy, tasty, produced in a nature-friendly way.',
        title: 'Fresh Food',
        image: 'assets/images/onboarding/food1.png'),
    BoardingModel(
        body: "Express delivery is the fastest form of shipping",
        title: 'Fast Delivery',
        image: 'assets/images/onboarding/food3.png'),
    BoardingModel(
        body: 'of doing or experiencing something: We enjoyed the scenery.',
        title: 'Enjoy today',
        image: 'assets/images/onboarding/food2.png'),
  ];

  bool isLast = false;

  void submit() {
    CashHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        Navigator.pushNamed(
          context,
          LoginScreen.id,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        actions: [defaultTextButton(function: submit, text: 'skip')],
      ),
      body: Container(
        color: kMainColor,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardController,
                      effect: ExpandingDotsEffect(
                        dotColor: kSecondaryColor,
                        activeDotColor: kSecondaryColor,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5,
                      ),
                      count: boarding.length),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: kSecondaryColor,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}'.toUpperCase(),
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 10.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
