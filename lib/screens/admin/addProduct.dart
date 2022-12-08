// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:food/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/productModel.dart';
import '../../services/store.dart';
import '../../widget/customTextField.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? name, price, description, category, imageLocation;

  late final GlobalKey<FormFieldState> categoryKey;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final store = Store();
  final List<String> CategoryItems = [
    kFood,
    kDrink,
    kOffers,
  ];
  String? selectedCategoryValue;
  final List<String> ImageItems = [
    'assets/images/drink/d1.png',
    'assets/images/drink/d2.jpg',
    'assets/images/drink/d3.png',

    'assets/images/drink/d4.jpg',

    'assets/images/drink/d5.jpg',

    //
    'assets/images/food/f1.png',
    'assets/images/food/f2.jpg',
    'assets/images/food/f3.png',
    'assets/images/food/f4.png',
    'assets/images/food/f5.jpg',
    'assets/images/food/f6.jpg',
    'assets/images/food/f7.jpg',

    //
    'assets/images/offers/o1.png',
    'assets/images/offers/o2.png',
    'assets/images/offers/o3.jpg',
    'assets/images/offers/o4.jpg',

    //
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product Price',
              onClick: (value) {
                price = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product Description',
              onClick: (value) {
                description = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Icon(
                        Icons.list,
                        size: 16,
                        color: kSecondaryColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'Select Category',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: CategoryItems.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )).toList(),
                  value: category,
                  onChanged: (value) {
                    setState(() {
                      category = value as String;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: kSecondaryColor,
                  iconDisabledColor: kSecondaryColor,
                  buttonHeight: 50,
                  buttonWidth: 300,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: kSecondaryColor,
                    ),
                    color: kMainColor,
                  ),
                  buttonElevation: 2,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 10, right: 10),
                  dropdownMaxHeight: 200,
                  dropdownWidth: 200,
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kMainColor,
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(20),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(-20, 0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Icon(
                        Icons.list,
                        size: 16,
                        color: kSecondaryColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'Select ImagePath',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: ImageItems.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )).toList(),
                  value: imageLocation,
                  onChanged: (value) {
                    setState(() {
                      imageLocation = value as String;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: kSecondaryColor,
                  iconDisabledColor: kSecondaryColor,
                  buttonHeight: 50,
                  buttonWidth: 300,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: kSecondaryColor,
                    ),
                    color: kMainColor,
                  ),
                  buttonElevation: 2,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 10, right: 10),
                  dropdownMaxHeight: 200,
                  dropdownWidth: 220,
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kMainColor,
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(20),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(-20, 0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kSecondaryColor,
              ),
              onPressed: () {
                if (globalKey.currentState!.validate()) {
                  globalKey.currentState!.save();
                  // globalKey.currentState!.reset();
                  store.AddProduct(Product(
                    pName: name,
                    pPrice: price,
                    pCategory: category,
                    pDescription: description,
                    pLocation: imageLocation,
                  ));
                }
              },
              child: Text(
                'Add Product',
                style: GoogleFonts.lato(fontSize: 21, color: kMainColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
