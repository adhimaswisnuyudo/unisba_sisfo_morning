import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unisba_sisfo/config/constanta.dart' as cs;
import 'package:unisba_sisfo/handlers/screen.dart';
import 'package:unisba_sisfo/menus/main_menu.dart';
import 'package:unisba_sisfo/models/sisfo_menu.dart';
import 'package:unisba_sisfo/pages/login.dart';
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

  List<SisfoMenu> sisfoMenu = [
    SisfoMenu(title: "SIBIMA", icon: cs.iconSibima, route: '#'),
    SisfoMenu(
        title: "SIAKAD",
        icon: cs.iconSiakad,
        route: 'https://siakad.unisba.ac.id'),
    SisfoMenu(
        title: "SIDPP",
        icon: cs.iconSidpp,
        route: 'https://sidpp.unisba.ac.id'),
    SisfoMenu(
        title: "RPS & BAP",
        icon: cs.iconRpsbap,
        route: 'https://rps.unisba.ac.id'),
    SisfoMenu(
        title: "Scholarship",
        icon: cs.iconScholarship,
        route: 'https://unisba.ac.id'),
    SisfoMenu(
        title: "Pesantren",
        icon: cs.iconPesantren,
        route: 'https://pesantren.unisba.ac.id'),
    SisfoMenu(
        title: "TOEFL",
        icon: cs.iconToefl,
        route: 'https://toefl.unisba.ac.id'),
    SisfoMenu(
        title: "Graduation",
        icon: cs.iconGraduation,
        route: 'https://sibima.unisba.ac.id'),
  ];

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

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(cs.spActiveUser);
    prefs.remove(cs.spTokenKey);
    prefs.remove(cs.spIsLogin);
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: LoginPage(), type: PageTransitionType.bottomToTop));
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
            IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.exit_to_app),
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
                        radius: deviceWidth * 0.15,
                        backgroundImage: NetworkImage(mhs.foto.toString()),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.02),
                    Center(
                      child: Text(
                        mhs.npm.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.02),
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
          ),
          Positioned(
            top: deviceHeight * 0.30,
            left: 15,
            right: 15,
            child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 15,
                  children: [
                    for (var i in sisfoMenu)
                      sisfoMenuItem(i.title, i.icon, i.route)
                  ],
                ),
              ),
            ),
          )
        ]));
  }

  Widget sisfoMenuItem(String title, String icon, String route) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        GestureDetector(
          onTap: () => {Fluttertoast.showToast(msg: title)},
          child: Image.asset(
            icon,
            width: deviceWidth * 0.15,
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(fontSize: deviceWidth * 0.03),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
