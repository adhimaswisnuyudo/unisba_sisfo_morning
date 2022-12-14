import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unisba_sisfo/config/constanta.dart' as cs;
import 'package:unisba_sisfo/handlers/screen.dart';
import 'package:unisba_sisfo/menus/main_menu.dart';
import 'package:unisba_sisfo/models/sisfo_menu.dart';
import 'package:unisba_sisfo/pages/login.dart';
import 'package:unisba_sisfo/pages/postmore.dart';
import 'package:unisba_sisfo/pages/webview.dart';
import '../models/active_user.dart';
import '../models/slider.dart';

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
    SisfoMenu(
        title: "SIBIMA",
        icon: cs.iconSibima,
        route: 'https://sibima.unisba.ac.id'),
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

  List<SisfoSlider> sliderList = [];

  @override
  void initState() {
    getActiveUser();
    getSliders();
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
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Sisfo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove(cs.spActiveUser);
                prefs.remove(cs.spIsLogin);
                prefs.remove(cs.spTokenKey);
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: LoginPage(),
                        type: PageTransitionType.bottomToTop));
              },
            )
          ],
        );
      },
    );
  }

  void openWebView(String title, String url) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: WebViewPage(
              title: title,
              url: url,
            )));
  }

  Future<void> getSliders() async {
    setState(() {
      isLoading = true;
    });
    Dio dio = Dio();
    var response = await dio.get(cs.sliderUrl);
    if (response.statusCode == 200) {
      setState(() {
        for (var i in response.data) {
          sliderList.add(SisfoSlider(
            id: i['id'].toString(),
            title: i['title']['rendered'],
            image: i['jetpack_featured_media_url'],
            link: i['link'],
          ));
        }
        isLoading = false;
      });
    } else {
      Fluttertoast.showToast(msg: "Unable to load news");
    }
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
            Align(
              child: Badge(
                position: BadgePosition.topEnd(top: 1, end: 2),
                badgeContent: const Text(
                  '0',
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    icon: const Icon(Icons.notifications), onPressed: () {}),
              ),
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
                    SizedBox(height: deviceHeight * 0.01),
                    Center(
                      child: CircleAvatar(
                        radius: deviceWidth * 0.15,
                        backgroundImage: NetworkImage(mhs.foto.toString()),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.01),
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
                        child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        // overflow: TextOverflow.ellipsis,
                        mhs.nama.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
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
                        onPressed: () => {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: PostMorePage(),
                                  type: PageTransitionType.bottomToTop))
                        },
                      )))
                ],
              ),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: deviceHeight * 0.165,
                  child: isLoading
                      ? Center(
                          child: SpinKitCubeGrid(color: Colors.blue),
                        )
                      : CarouselSlider(
                          options: CarouselOptions(height: 400.0),
                          items: sliderList.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Card(
                                  child: InkWell(
                                      onTap: () =>
                                          {openWebView(i.title, i.link)},
                                      child: Column(
                                        children: [
                                          Container(
                                            height: deviceHeight * 0.1,
                                            width: deviceWidth,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            child: Image.network(
                                              i.image,
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  // ignore: curly_braces_in_flow_control_structures
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            child: Text(
                                              i.title,
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              },
                            );
                          }).toList(),
                        )),
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
          onTap: () => {
            openWebView(title, route),
          },
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
