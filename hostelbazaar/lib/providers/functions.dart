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
    String callUrl = "$URL/order/last/10";
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

  dynamic getPreviousOrders(String token) async {
    String callUrl = "$URL/order/me";
    final response = await http.get(Uri.parse(callUrl), headers: {
      "Authorization": "Bearer $token",
    });
    print(response.body);
    var data = json.decode(response.body);
    return data;
  }

  dynamic searchProduct(String search, String token) async {
    String callUrl = "$URL/product/searchUnique/$search";
    final response = await http.get(Uri.parse(callUrl), headers: {
      "Authorization": "Bearer $token",
    });
    print(response.body);
    var data = json.decode(response.body);
    return data;
  }

  dynamic searchUniqueProduct(String search, String token) async {
    String callUrl = "$URL/product/search/$search";
    final response = await http.get(Uri.parse(callUrl), headers: {
      "Authorization": "Bearer $token",
    });
    print(response.body);
    var data = json.decode(response.body);
    return data;
  }

  dynamic getLastOrderUser(String token) async {
    String callUrl = "$URL/order/user/last/0";
    final response = await http.get(Uri.parse(callUrl), headers: {
      "Authorization": "Bearer $token",
    });
    print(response.body);
    var data = json.decode(response.body);

    List<String> sellers = [];
    Map<String, dynamic> sellerDetails = {};
    Map<String, dynamic> orders = {};
    Map<String, int> total = {};

    for (int i = 0; i < data[0]["items"].length; i++) {
      var curr = data[0]["items"][i];
      if (orders.isNotEmpty && orders.containsKey(curr["product"]["sellerId"]["_id"])) {
        orders[curr["product"]["sellerId"]["_id"]]!.add(curr);
        total[curr["product"]["sellerId"]["_id"]] = total[curr["product"]["sellerId"]["_id"]]! + (int.parse(curr["product"]["price"].toString()) * int.parse(curr["quantity"].toString()));
        continue;
      }

      orders.addAll({
        curr["product"]["sellerId"]["_id"]: [curr]
      });
      total.addAll({curr["product"]["sellerId"]["_id"]: (int.parse(curr["product"]["price"].toString()) * int.parse(curr["quantity"].toString()))});
      sellerDetails.addAll({curr["product"]["sellerId"]["_id"]: curr["product"]["sellerId"]});
      sellers.add(curr["product"]["sellerId"]["_id"]);
    }
    print(orders);

    return [sellers, orders, sellerDetails, total];
  }

  dynamic addToWishlist(String token, String id) async {
    String callUrl = "$URL/profile/saved/add";
    final response = await http.post(Uri.parse(callUrl), headers: {
      "Authorization": "Bearer $token",
    }, body: {
      "itemId": id,
    });
    print(response.body);
    var data = json.decode(response.body);
    return data;
  }

  dynamic getWishlist(String token) async {
    String callUrl = "$URL/profile/saved/me";
    final response = await http.get(Uri.parse(callUrl), headers: {
      "Authorization": "Bearer $token",
    });
    print(response.body);
    var data = json.decode(response.body);
    return data;
  }

  dynamic removeFromWishlist(String token, String id) async {
    String callUrl = "$URL/profile/saved/rm";
    final response = await http.post(Uri.parse(callUrl), headers: {
      "Authorization": "Bearer $token",
    }, body: {
      "itemId": id,
    });
    print(response.body);
    var data = json.decode(response.body);
    return data;
  }

  dynamic rateProduct(String prodId, double rating, String comment, String token, String userid) async {
    String callUrl = "$URL/product/review/single";
    final response = await http.post(Uri.parse(callUrl), headers: {
      "Authorization": "Bearer $token",
    }, body: {
      "productId": prodId,
      "rating": rating.toString(),
      "comment": comment,
      "userId": userid,
    });
    print(response.body);
    var data = json.decode(response.body);
    return data;
  }

  dynamic sendOtp(String number) async {
    String callUrl = "$URL/otp/send-otp";
    final response = await http.post(Uri.parse(callUrl), body: {
      "number": number,
    });
    print(response.body);
    var data = json.decode(response.body);
    return data;
  }

  dynamic verifyOtp(String number, String otp) async {
    String callUrl = "$URL/otp/verify-otp";
    final response = await http.post(
      Uri.parse(callUrl),
      body: {
        "number": number,
        "otp": otp,
      },
    );
    print(response.body);
    var data = json.decode(response.body);
    return data;
  }

  dynamic getColleges() async {
    String callUrl = "$URL/admin/college/all";
    final response = await http.get(
      Uri.parse(callUrl),
    );
    print(response.body);
    var data = json.decode(response.body);
    return data;
  }

  dynamic getHostels(String id) async {
    String callUrl = "$URL/admin/hostel/all?collegeId=" + id;
    final response = await http.get(
      Uri.parse(callUrl),
    );
    print(response.body);
    var data = json.decode(response.body);
    return data;
  }

  dynamic signUp(Map<String, String> body) async {
    String callUrl = "$URL/auth/signup";
    final response = await http.post(Uri.parse(callUrl), body: body);
    print(response.body);
    var data = json.decode(response.body);
    return data;
  }
}
