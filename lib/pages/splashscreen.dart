import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:unisba_sisfo/config/constanta.dart' as cs;
import 'package:unisba_sisfo/pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    redirectPage();
    super.initState();
  }

  void redirectPage() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: LoginPage(), type: PageTransitionType.bottomToTop));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double logoSize = height * 0.3;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: Image.asset(
        cs.mainLogo,
        width: logoSize,
        height: logoSize,
      )),
    );
  }
}
