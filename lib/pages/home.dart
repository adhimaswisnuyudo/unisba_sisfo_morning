import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unisba_sisfo/config/constanta.dart' as cs;
import 'package:unisba_sisfo/handlers/screen.dart';
import 'package:unisba_sisfo/menus/main_menu.dart';

import '../models/active_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ActiveUser mhs = ActiveUser();
  bool isLoading = true;

  @override
  void initState() {
    getActiveUser();
    super.initState();
  }

  Future<void> getActiveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? activeUser = prefs.getString(cs.spActiveUser);
    setState(() {
      mhs = ActiveUser.fromJson(jsonDecode(activeUser!));
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = DeviceScreen().getDeviceWidth();
    double deviceHeight = DeviceScreen().getDeviceHeight();
    return Scaffold(
        appBar: AppBar(
          leading: Image.asset(cs.mainLogo, height: 50),
          title: Text(cs.appName),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
            ),
          ],
        ),
        bottomNavigationBar: MainMenu(),
        body: Stack(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: deviceWidth,
                height: deviceHeight * 0.4,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(deviceWidth, 100)),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: deviceHeight * 0.03),
                    Center(
                      child: CircleAvatar(
                        radius: deviceWidth * 0.2,
                        backgroundImage: NetworkImage(mhs.foto.toString()),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.03),
                    Center(
                      child: Text(
                        mhs.npm.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.01),
                    Center(
                      child: Text(
                        mhs.nama.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: deviceHeight * 0.15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: deviceWidth * 0.03),
                      child: (Text(
                        "Latest News",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ))),
                  Container(
                      padding: EdgeInsets.only(right: deviceWidth * 0.03),
                      child: (TextButton(
                        child: Text(
                          "See More",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () => {print("See More..")},
                      )))
                ],
              )
            ],
          )
        ]));
  }
}
