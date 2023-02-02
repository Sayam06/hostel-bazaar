import 'package:flutter/material.dart';
import 'package:hostelbazaar/footer.dart';
import 'package:hostelbazaar/header.dart';
import 'package:hostelbazaar/palette.dart';
import 'package:hostelbazaar/providers/functions.dart';
import 'package:hostelbazaar/providers/user.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class YourOrdersScreen extends StatefulWidget {
  static const routeName = "/orders";

  @override
  State<YourOrdersScreen> createState() => _YourOrdersScreenState();
}

class _YourOrdersScreenState extends State<YourOrdersScreen> {
  bool isLoading = true;
  var userProv;
  late List<dynamic> data;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    data = await API().getPreviousOrders(userProv.token);
    data = new List.from(data.reversed);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    userProv = Provider.of<User>(context, listen: false);
    getData();
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: Text(
                          "Your Orders",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
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
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                data[index]["items"].length > 1
                                    ? Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            data[index]["items"][0]["product"]["name"],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            " +" + (data[index]["items"].length - 1).toString() + " others",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )
                                    : Text(
                                        data[index]["items"][0]["product"]["name"],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                Text(
                                  "Order placed on " + DateFormat("dd MMMM, yyyy").format(DateTime.parse(data[index]["createdAt"])),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: mainColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                    itemCount: data.length,
                    padding: EdgeInsets.all(0),
                  ),
                ),
                Footer(current: ""),
              ],
            ),
    );
  }
}
