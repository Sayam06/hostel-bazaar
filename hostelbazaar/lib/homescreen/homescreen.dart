import 'package:flutter/material.dart';
import 'package:hostelbazaar/footer.dart';
import 'package:hostelbazaar/header.dart';
import 'package:hostelbazaar/palette.dart';
import 'package:hostelbazaar/product-list%20screen/product_list_screen.dart';
import 'package:hostelbazaar/providers/functions.dart';
import 'package:hostelbazaar/providers/user.dart';
import 'package:hostelbazaar/search-screen/search_screen.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  static const routeName = "/home";

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final searchController = new TextEditingController();
  List<dynamic> searchResults = [];
  bool isLoading = true;
  var userProv;
  var wishlistProv;

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

  void search() async {
    setState(() {
      isLoading = true;
    });
    var response = await API().searchUniqueProduct(searchController.text, userProv.token);
    userProv.selectedCategoryProductList = response;
    Navigator.of(context).pushNamed(SearchScreen.routeName).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    userProv = Provider.of<User>(context, listen: false);
    wishlistProv = Provider.of<User>(context, listen: false);
    initialiseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgcolor,
      resizeToAvoidBottomInset: false,
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
                        margin: index == 0 ? EdgeInsets.only(left: w * 0.06, right: 5) : EdgeInsets.symmetric(horizontal: 5),
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
                    padding: EdgeInsets.symmetric(horizontal: w * 0.06),
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
                                  onChanged: (_) async {
                                    if (searchController.text.isEmpty) {
                                      setState(() {
                                        searchResults = [];
                                      });
                                      return;
                                    }
                                    searchResults = await API().searchProduct(searchController.text, userProv.token);
                                    setState(() {});
                                  },
                                ),
                              )),
                              GestureDetector(
                                  onTap: () {
                                    if (searchController.text.isNotEmpty) search();
                                  },
                                  child: Image.asset("assets/images/search.png")),
                            ],
                          ),
                        ),
                        if (searchResults.length != 0)
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: 200,
                            ),
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: bgLite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  ...searchResults.map((e) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (searchController.text.isNotEmpty) search();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 10),
                                            width: double.infinity,
                                            child: Text(
                                              e["name"],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                          thickness: 0.5,
                                        ),
                                      ],
                                    );
                                  }),
                                  SizedBox(height: 10),
                                ],
                              ),
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
                                    productCat("munchies", userProv, w),
                                    SizedBox(height: 10),
                                    productCat("bakery", userProv, w),
                                    SizedBox(height: 10),
                                    productCat("grooming", userProv, w),
                                    SizedBox(height: 10),
                                  ],
                                ),
                                // SizedBox(width: 10),
                                Column(
                                  children: [
                                    productCat("drinks", userProv, w),
                                    SizedBox(height: 10),
                                    productCat("electronics", userProv, w),
                                    SizedBox(height: 10),
                                    productCat("daily fresh", userProv, w),
                                    SizedBox(height: 10),
                                    productCat("misc", userProv, w),
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
                Footer(current: "home"),
              ],
            ),
    );
  }

  GestureDetector productCat(String img, var userProv, var w) {
    return GestureDetector(
      child: Container(
          width: w * 0.42,
          child: Image.asset(
            "assets/images/$img.png",
            fit: BoxFit.fill,
          )),
      onTap: () {
        userProv.selectedCategory = img;
        Navigator.of(context).pushNamed(ProductListScreen.routeName);
      },
    );
  }
}
