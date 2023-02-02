import 'package:flutter/material.dart';
import 'package:hostelbazaar/palette.dart';
import 'package:hostelbazaar/providers/functions.dart';
import 'package:hostelbazaar/signup-login%20screen/hostel_screen.dart';

class OTPScreen extends StatefulWidget {
  static const routeName = "/otp";

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool otpGenerated = false;
  final phoneController = new TextEditingController();
  final otpController = new TextEditingController();
  bool otp = false;

  bool checkValid() {
    if (phoneController.text.length < 10) return false;
    if (phoneController.text.contains('.')) return false;
    if (phoneController.text.contains(',')) return false;
    if (phoneController.text.contains('-')) return false;
    return true;
  }

  void sendOtp() async {
    setState(() {
      otp = true;
    });
    var response = await API().sendOtp("+91" + phoneController.text);
    if (response["message"] == "OTP sent successfully")
      otpGenerated = true;
    else {
      final snackBar = SnackBar(
        content: Text("Oops! There seems to be an error!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      otp = false;
    });
  }

  void verify() async {
    setState(() {
      otp = true;
    });
    var response = await API().verifyOtp("+91" + phoneController.text, otpController.text);
    if (response["message"] == "OTP verified successfully")
      Navigator.of(context).pushNamedAndRemoveUntil(HostelScreen.routeName, (route) => false);
    else {
      setState(() {
        otp = false;
      });
      final snackBar = SnackBar(
        content: Text("Oops! There seems to be an error!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 120),
              Container(
                height: 50,
                child: Image.asset(
                  "assets/images/logo.png",
                ),
              ),
              SizedBox(height: 100),
              inputText("Phone Number", phoneController, false),
              SizedBox(height: 20),
              inputText("OTP", otpController, false),
              SizedBox(height: 40),
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Container(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {
                        if (otp) return;
                        if (checkValid())
                          sendOtp();
                        else {
                          final snackBar = SnackBar(
                            content: Text("Please enter a valid number!"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                      ),
                      child: otp
                          ? Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : Text(
                              "Get OTP",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                              ),
                            )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Container(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      if (otp) return;
                      if (otpController.text.length == 0) {
                        final snackBar = SnackBar(
                          content: Text("Please enter a valid OTP!"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      if (otpGenerated) verify();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                    ),
                    child: otp
                        ? Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : Text(
                            "Next",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container inputText(String hintText, TextEditingController controller, bool password) {
    return Container(
      height: 50,
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextField(
          keyboardType: TextInputType.phone,
          obscureText: password ? true : false,
          controller: controller,
          decoration: InputDecoration.collapsed(
            hintText: "$hintText",
          ),
        ),
      ),
    );
  }
}
