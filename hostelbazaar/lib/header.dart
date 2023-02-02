import 'package:flutter/material.dart';
import 'package:hostelbazaar/palette.dart';
import 'package:hostelbazaar/wishlist_screen/wishlist_screen.dart';

class Header extends StatelessWidget {
  bool showWishlist;

  Header({this.showWishlist = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          height: 50,
          // color: Colors.yellow,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 30,
                      child: Image.asset(
                        "assets/images/logo.png",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (showWishlist)
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(WishlistScreen.routeName);
                        },
                        child: Container(
                          // color: Colors.blue,
                          // height: 30,
                          margin: EdgeInsets.only(top: 10),
                          child: Image.asset("assets/images/like.png"),
                        ),
                      ),
                    SizedBox(width: 20),
                    Container(
                      // color: Colors.blue,
                      // height: 30,
                      margin: EdgeInsets.only(top: 10),
                      child: Image.asset("assets/images/user.png"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: primaryColor,
        ),
      ],
    );
  }
}
