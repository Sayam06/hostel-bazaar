import 'package:flutter/material.dart';
import 'package:hostelbazaar/homescreen/homescreen.dart';
import 'package:hostelbazaar/product-list%20screen/product_details_screen.dart';
import 'package:hostelbazaar/product-list%20screen/product_list_screen.dart';
import 'package:hostelbazaar/signup-login%20screen/login_screen.dart';
import 'package:hostelbazaar/signup-login%20screen/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: "Poppins",
      ),
      home: LoginScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        Homescreen.routeName: (ctx) => Homescreen(),
        ProductListScreen.routeName: (ctx) => ProductListScreen(),
        ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
      },
    );
  }
}
