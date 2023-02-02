import 'package:flutter/material.dart';
import 'package:hostelbazaar/cart_screen/order_placed_screen.dart';
import 'package:hostelbazaar/footer.dart';
import 'package:hostelbazaar/header.dart';
import 'package:hostelbazaar/palette.dart';
import 'package:hostelbazaar/providers/cart.dart';
import 'package:hostelbazaar/providers/functions.dart';
import 'package:hostelbazaar/providers/user.dart';
import 'package:hostelbazaar/providers/wishlist.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = "/productDetails";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isLoading = true;
  var userProv;
  var wishlistProv;
  Map<String, dynamic> product = {};
  int qty = 1;

  void initialise() async {
    setState(() {
      isLoading = true;
    });
    product = userProv.selectedProduct;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    userProv = Provider.of<User>(context, listen: false);
    wishlistProv = Provider.of<Wishlist>(context, listen: false);
    initialise();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          product["sellerId"]["name"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          product["name"],
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
                              "₹ " + product["price"].toString(),
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  if (!wishlistProv.containsProduct(product["_id"])) {
                                    var response = await API().addToWishlist(userProv.token, product["_id"]);
                                    wishlistProv.addProduct(product);
                                  } else {
                                    var response = await API().removeFromWishlist(userProv.token, product["_id"]);
                                    wishlistProv.removeProduct(product["_id"]);
                                  }
                                },
                                child: Consumer<Wishlist>(
                                  builder: (context, value, child) => Container(
                                    child: !wishlistProv.containsProduct(product["_id"])
                                        ? Image.asset("assets/images/unlike.png")
                                        : Container(
                                            height: 10,
                                            width: 10,
                                            color: Colors.white,
                                          ),
                                  ),
                                ))
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
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (qty == 1) return;
                                  setState(() {
                                    qty--;
                                  });
                                },
                                child: Container(
                                  color: secondaryColor,
                                  child: Icon(
                                    Icons.remove,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                qty.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  if (qty == product["quantity"]) return;
                                  setState(() {
                                    qty++;
                                  });
                                },
                                child: Container(
                                  color: secondaryColor,
                                  child: Icon(Icons.add, color: primaryColor),
                                ),
                              )
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
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      var cartProv = Provider.of<Cart>(context, listen: false);
                                      await cartProv.buyNow(
                                        Provider.of<User>(context, listen: false).token,
                                        product["_id"],
                                        qty,
                                      );
                                      Navigator.of(context).pushNamed(OrderPlacedScreen.routeName).then((value) => setState(() {
                                            isLoading = false;
                                          }));
                                    },
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
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      var cartProv = Provider.of<Cart>(context, listen: false);
                                      cartProv.addItem(product, qty);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            Future.delayed(Duration(milliseconds: 1500), () {
                                              Navigator.of(context).pop(true);
                                            });
                                            return StatefulBuilder(builder: (context, StateSetter setStat) {
                                              return Center(
                                                child: Container(
                                                    width: 250,
                                                    height: 250,
                                                    decoration: BoxDecoration(
                                                      color: secondaryColor,
                                                      borderRadius: BorderRadius.circular(360),
                                                      border: Border.all(color: primaryColor),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.done,
                                                          size: 100,
                                                          color: primaryColor,
                                                        ),
                                                        DefaultTextStyle(
                                                          style: TextStyle(
                                                            color: primaryColor,
                                                            fontFamily: "Poppins",
                                                            fontSize: 16,
                                                          ),
                                                          child: Text(
                                                            "Added to cart!",
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              );
                                            });
                                          });
                                    },
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
                          product["description"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                )),
                Footer(current: "")
              ],
            ),
    );
  }
}
