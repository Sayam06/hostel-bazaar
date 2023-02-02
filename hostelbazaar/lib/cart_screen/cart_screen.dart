import 'package:flutter/material.dart';
import 'package:hostelbazaar/cart_screen/order_placed_screen.dart';
import 'package:hostelbazaar/footer.dart';
import 'package:hostelbazaar/header.dart';
import 'package:hostelbazaar/palette.dart';
import 'package:hostelbazaar/providers/cart.dart';
import 'package:hostelbazaar/providers/user.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var cartProv;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    cartProv = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      backgroundColor: bgcolor,
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Cart",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<Cart>(
                  builder: (context, value, child) => Expanded(
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        var item = cartProv.cartItems[index];
                        return Container(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    item["name"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (item["sellerId"]["name"].length < 10)
                                    Text(
                                      item["sellerId"]["name"].toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  if (item["sellerId"]["name"].length >= 10)
                                    Text(
                                      item["sellerId"]["name"].toString().substring(0, 10) + "...",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          cartProv.reduceQty(item);
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
                                        cartProv.qty[item["_id"]].toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      GestureDetector(
                                        onTap: () {
                                          cartProv.increaseQty(item);
                                        },
                                        child: Container(
                                          color: secondaryColor,
                                          child: Icon(Icons.add, color: primaryColor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    "₹ " + item["price"].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Delivery Fee",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "₹ 10",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  GestureDetector(
                                      onTap: () {
                                        cartProv.removeFromCart(item);
                                      },
                                      child: Image.asset("assets/images/delete.png")),
                                  SizedBox(height: 10),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                      itemCount: cartProv.cartItems.length,
                    ),
                  ),
                ),
                Consumer<Cart>(
                  builder: (context, value, child) => Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          "Sub total: ₹ ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          cartProv.getTotal().toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (cartProv.qty.isEmpty) return;
                        await cartProv.checkOut(Provider.of<User>(context, listen: false).token);
                        Navigator.of(context).pushNamed(OrderPlacedScreen.routeName).then((value) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Footer(current: "cart")
              ],
            ),
    );
  }
}
