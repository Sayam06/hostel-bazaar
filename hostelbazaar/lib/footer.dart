import 'package:flutter/material.dart';
import 'package:hostelbazaar/cart_screen/cart_screen.dart';
import 'package:hostelbazaar/homescreen/homescreen.dart';
import 'package:hostelbazaar/palette.dart';
import 'package:hostelbazaar/providers/user.dart';
import 'package:provider/provider.dart';

class Footer extends StatelessWidget {
  String current;
  Footer({required this.current});
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
          GestureDetector(
              onTap: () {
                if (current == "home") return;
                Navigator.of(context).pushNamed(Homescreen.routeName);
              },
              child: Container(
                  width: 50,
                  // color: Colors.amber,
                  child: Container(
                    width: 50,
                    height: 40,
                    decoration: current == "home"
                        ? BoxDecoration(
                            color: Color.fromRGBO(141, 134, 157, 0.43),
                            borderRadius: BorderRadius.circular(19),
                          )
                        : null,
                    child: Image.asset("assets/images/home.png"),
                  ))),
          GestureDetector(
              onTap: () {},
              child: Container(
                  height: 40,
                  width: 50,
                  decoration: current == "idk"
                      ? BoxDecoration(
                          color: Color.fromRGBO(141, 134, 157, 0.43),
                          borderRadius: BorderRadius.circular(19),
                        )
                      : null,
                  child: Image.asset("assets/images/category.png"))),
          GestureDetector(
              onTap: () {
                if (current == "cart") return;
                // userProv.selectedPage = "cart";
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              child: Container(
                  width: 50,
                  height: 40,
                  decoration: current == "cart"
                      ? BoxDecoration(
                          color: Color.fromRGBO(141, 134, 157, 0.43),
                          borderRadius: BorderRadius.circular(19),
                        )
                      : null,
                  child: Image.asset("assets/images/cart.png"))),
        ],
      ),
    );
  }
}
