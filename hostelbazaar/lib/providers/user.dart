import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String name = "";
  String email = "";
  String password = "";
  Map<String, dynamic> college = {};
  Map<String, dynamic> hostel = {};
  int selectedImg = -1;

  String token = "";
  String id = "";

  String selectedPage = "home";
  dynamic lastNOrders;

  String selectedCategory = "";
  List<dynamic> selectedCategoryProductList = [];
  Map<String, dynamic> selectedProduct = {};
  int selectedProductIndex = -1;

  String selectedReviewProductId = "";

  void setToken(String t) {
    token = t;
  }
}
