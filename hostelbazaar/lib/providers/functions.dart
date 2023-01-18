import 'dart:convert';

import 'package:hostelbazaar/providers/user.dart';
import 'package:hostelbazaar/url.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class API {
  dynamic login(String email, String password) async {
    String callUrl = "$URL/auth/login";
    final response = await http.post(
      Uri.parse(callUrl),
      body: {
        "email": email,
        "password": password,
      },
    );
    print(response.body);
    var data = jsonDecode(response.body);
    return data;
  }

  dynamic getLastNOrders(String token) async {
    String callUrl = "$URL/order/last/2";
    final response = await http.get(
      Uri.parse(callUrl),
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    print(response.body);
    var data = jsonDecode(response.body);
    return data;
  }

  dynamic getProductsByCategory(String category, String token) async {
    String callUrl = "$URL/product/category/$category";
    final response = await http.get(
      Uri.parse(callUrl),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print(response.body);
    var data = jsonDecode(response.body);
    return data;
  }

  dynamic checkOut(Map<String, dynamic> checkOutData, String token) async {
    String callUrl = "$URL/product/buy";
    var postData = json.encode(checkOutData);
    print(postData);
    final response = await http.post(
      Uri.parse(callUrl),
      headers: {
        "Authorization": "Bearer $token",
      },
      body: postData,
    );
    print(response.body);
    var data = jsonDecode(response.body);
    return data;
  }
}
