import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unisba_sisfo/config/constanta.dart' as cs;
import 'package:unisba_sisfo/pages/login.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    isLogin();
    super.initState();
  }

  Future<void> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool(cs.spIsLogin) ?? false;
    if (isLogin == true) {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.pushReplacement(
              context,
              PageTransition(
                  child: HomePage(), type: PageTransitionType.bottomToTop)));
    } else {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.pushReplacement(
              context,
              PageTransition(
                  child: LoginPage(), type: PageTransitionType.bottomToTop)));
    }
  }

  void redirectPage() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const LoginPage(), type: PageTransitionType.bottomToTop));
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double logoSize = deviceWidth * 0.8;
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 0.25 * deviceHeight),
              Image.asset(cs.mainLogo, width: logoSize, height: logoSize),
              const SizedBox(height: 15),
              const Text(cs.appName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  )),
              const SizedBox(height: 50),
              const SpinKitCubeGrid(
                color: Colors.white,
                size: 25.0,
              ),
            ],
          ),
        ));
  }
}
