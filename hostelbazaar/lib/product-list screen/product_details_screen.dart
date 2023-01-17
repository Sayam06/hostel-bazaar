import 'package:flutter/material.dart';
import 'package:hostelbazaar/footer.dart';
import 'package:hostelbazaar/header.dart';
import 'package:hostelbazaar/palette.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = "/details";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(),
          SizedBox(height: 20),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Seller Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Product Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.maxFinite,
                    height: 300,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹ 200",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset("assets/images/unlike.png")
                    ],
                  ),
                  Text(
                    "Delivery charge: ₹ 10",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "In stock.",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "qty: 1",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Buy Now",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "bla bla bla",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          )),
          Footer(),
        ],
      ),
    );
  }
}
