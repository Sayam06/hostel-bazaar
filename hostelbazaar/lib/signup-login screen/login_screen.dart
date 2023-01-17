import 'package:flutter/material.dart';
import 'package:hostelbazaar/homescreen/homescreen.dart';
import 'package:hostelbazaar/palette.dart';
import 'package:hostelbazaar/signup-login%20screen/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        width: MediaQuery.of(context).size.width,
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
            SizedBox(height: 100),
            inputText("Email", emailController),
            SizedBox(height: 20),
            inputText("Password", emailController),
            SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Container(
                height: 40,
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Homescreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                    ),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                      ),
                    )),
              ),
            ),
            SizedBox(height: 130),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(SignupScreen.routeName);
                  },
                  child: Text(
                    "Sign up.",
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
    );
  }

  Container inputText(String hintText, TextEditingController controller) {
    return Container(
      height: 50,
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration.collapsed(
            hintText: "$hintText",
          ),
        ),
      ),
    );
  }
}
