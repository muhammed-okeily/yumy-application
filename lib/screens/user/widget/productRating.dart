/** 
import 'package:buying/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingWidget extends StatefulWidget {

  const RatingWidget({Key? key,}) : super(key: key  );

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
} 

class _RatingWidgetState extends State<RatingWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ratingBar(),
          quantityWidget(),
        ],
      ),
    );
  }

  Widget ratingBar() {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 0.5,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      unratedColor: Colors.grey,
      itemSize: 20,
      itemBuilder: (context, _) => const Icon(
        Icons.favorite,
        color: Colors.red,
      ),
      onRatingUpdate: (rating) {},
    );
  }

  Widget quantityWidget() {
    return Row(
      children: [
        GestureDetector(
          onTap: subtract,
          child: Container(
            padding:
                const EdgeInsets.only(top: 5, bottom: 20, right: 5, left: 5),
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: kMainColor),
            child: const Icon(
              Icons.minimize_outlined,
              size: 25,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
       Quantity.quantity.toString(),
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: add,
          child: Container(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, right: 5, left: 5),
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: kMainColor),
            child: const Icon(
              Icons.add,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }

  subtract() {
    if (Quantity.quantity > 0) {
      setState(() {
        Quantity.quantity--;
      });
    }
  }

  add() {
    setState(() {
      Quantity.quantity++;
    });
  }
}
**/