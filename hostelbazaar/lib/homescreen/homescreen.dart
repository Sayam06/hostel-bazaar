import 'package:flutter/material.dart';
import 'package:hostelbazaar/cart_screen/cart_screen.dart';
import 'package:hostelbazaar/footer.dart';
import 'package:hostelbazaar/header.dart';
import 'package:hostelbazaar/palette.dart';
import 'package:hostelbazaar/product-list%20screen/product_details_screen.dart';
import 'package:hostelbazaar/product-list%20screen/product_list_screen.dart';
import 'package:hostelbazaar/providers/functions.dart';
import 'package:hostelbazaar/providers/user.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  static const routeName = "/home";

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final searchController = new TextEditingController();
  bool isLoading = true;
  var userProv;
  String currentPage = "home";

  void changePage(String page) {
    setState(() {
      currentPage = page;
    });
  }

  void initialiseData() async {
    setState(() {
      isLoading = true;
    });
    dynamic response = await API().getLastNOrders(userProv.token);
    userProv.lastNOrders = response;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    userProv = Provider.of<User>(context, listen: false);
    initialiseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Column(
              children: [
                Header(),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: userProv.lastNOrders.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        height: 50,
                        width: 150,
                        margin: index == 0 ? EdgeInsets.only(left: 20, right: 5) : EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          height: 50,
                          child: Row(
                            children: [
                              Image.asset("assets/images/drawer.png"),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration.collapsed(hintText: "search"),
                                ),
                              )),
                              Image.asset("assets/images/search.png"),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          // height: 200,
                          child: SingleChildScrollView(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    productCat("munchies", userProv),
                                    SizedBox(height: 10),
                                    productCat("bakery", userProv),
                                    SizedBox(height: 10),
                                    productCat("grooming", userProv),
                                    SizedBox(height: 10),
                                  ],
                                ),
                                // SizedBox(width: 10),
                                Column(
                                  children: [
                                    productCat("drinks", userProv),
                                    SizedBox(height: 10),
                                    productCat("electronics", userProv),
                                    SizedBox(height: 10),
                                    productCat("daily fresh", userProv),
                                    SizedBox(height: 10),
                                    productCat("misc", userProv),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Footer(),
              ],
            ),
    );
  }

  GestureDetector productCat(String img, var userProv) {
    return GestureDetector(
      child: Image.asset("assets/images/$img.png"),
      onTap: () {
        userProv.selectedCategory = img;
        Navigator.of(context).pushNamed(ProductListScreen.routeName);
      },
    );
  }
}
