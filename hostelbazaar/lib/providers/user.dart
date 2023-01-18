import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String token = "";
  dynamic lastNOrders;

  String selectedCategory = "";
  List<dynamic> selectedCategoryProductList = [];
  Map<String, dynamic> selectedProduct = {};

  void setToken(String t) {
    token = t;
  }
}
