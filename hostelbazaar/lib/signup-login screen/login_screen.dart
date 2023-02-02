import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hostelbazaar/homescreen/homescreen.dart';
import 'package:hostelbazaar/palette.dart';
import 'package:hostelbazaar/providers/functions.dart';
import 'package:hostelbazaar/providers/user.dart';
import 'package:hostelbazaar/signup-login%20screen/details_screen.dart';
import 'package:hostelbazaar/signup-login%20screen/signup_screen.dart';
import 'package:hostelbazaar/url.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = new TextEditingController();

  final passwordController = new TextEditingController();

  void loginUser() async {
    var response = await API().login(emailController.text, passwordController.text);
    if (response["success"]) {
      Provider.of<User>(context, listen: false).token = response["accessToken"].toString().substring(7);
      Provider.of<User>(context, listen: false).id = JwtDecoder.decode(response["accessToken"])["user"]["_id"];
      Navigator.of(context).pushReplacementNamed(Homescreen.routeName);
    } else {
      final snackBar = SnackBar(
        content: Text(response["message"]),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    // print(response);
  }

  @override
  Widget build(BuildContext context) {
    // emailController.text = "mu.kaustav@gmail.com";
    // passwordController.text = "testing123";
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
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
              inputText("Email", emailController, false),
              SizedBox(height: 20),
              inputText("Password", passwordController, true),
              SizedBox(height: 40),
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Container(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {
                        loginUser();
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
      ),
    );
  }

  Container inputText(String hintText, TextEditingController controller, bool password) {
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
          obscureText: password ? true : false,
          decoration: InputDecoration.collapsed(
            hintText: "$hintText",
          ),
        ),
      ),
    );
  }
}
