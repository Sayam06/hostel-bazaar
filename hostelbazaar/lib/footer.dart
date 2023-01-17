import 'package:flutter/material.dart';
import 'package:hostelbazaar/palette.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          )),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset("assets/images/home.png"),
          Image.asset("assets/images/category.png"),
          Image.asset("assets/images/cart.png"),
        ],
      ),
    );
  }
}
