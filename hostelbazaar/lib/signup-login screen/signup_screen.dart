import 'package:flutter/material.dart';
import 'package:hostelbazaar/palette.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = "/signup";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                Container(
                  height: 50,
                  child: Image.asset(
                    "assets/images/logo.png",
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    Text(
                      "College Name: ",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Have an account? ",
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Log in.",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: primaryColor,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
