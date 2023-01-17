import 'package:flutter/material.dart';
import 'package:hostelbazaar/footer.dart';
import 'package:hostelbazaar/header.dart';
import 'package:hostelbazaar/palette.dart';
import 'package:hostelbazaar/product-list%20screen/product_details_screen.dart';

class ProductListScreen extends StatefulWidget {
  static const routeName = "/products";

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        children: [
          Header(),
          SizedBox(height: 20),
          Expanded(
              child: Column(
            children: [
              Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sort by: Popularity",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Text(
                            "Filters",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(ProductDetailsScreen.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Product Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "₹ 200",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "In stock.",
                                  style: TextStyle(
                                    color: mainColor,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  itemCount: 10,
                  padding: EdgeInsets.all(0),
                ),
              )
            ],
          )),
          Footer(),
        ],
      ),
    );
  }
}
