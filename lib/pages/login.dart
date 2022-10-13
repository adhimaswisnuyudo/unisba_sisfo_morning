import 'package:flutter/material.dart';
import 'package:unisba_sisfo/config/constanta.dart' as cs;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: ListView(
      children: [
        Container(
            height: 0.4 * deviceHeight,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 5)
                ],
                color: Colors.blue,
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(deviceWidth, 100))),
            child: Column(
              children: [
                SizedBox(height: deviceHeight * 0.03),
                Container(
                  child: Image.asset(
                    cs.mainLogo,
                    height: deviceWidth * 0.2,
                    width: 100,
                  ),
                ),
                SizedBox(height: deviceHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Mobile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text("SISFO",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 147, 0, 1),
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 5),
                const Text("Universitas Islam Bandung",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ],
            )),
        SizedBox(height: deviceHeight * 0.2),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: deviceHeight * 0.02),
        Container(
          padding: EdgeInsets.all(10),
          child: Card(
            elevation: 5,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[200]!))),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
