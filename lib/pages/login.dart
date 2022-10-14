import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unisba_sisfo/config/constanta.dart' as cs;
import 'package:unisba_sisfo/models/active_user.dart';
import 'package:unisba_sisfo/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObesecurePassword = true;
  bool isButtonEnable = false;
  bool isLoading = false;
  static Dio dio = Dio();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void setObsecurePassword(bool val) {
    setState(() {
      isObesecurePassword = val;
    });
  }

  Future<void> loginAction() async {
    var username = usernameController.text;
    var password = passwordController.text;
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Student ID are Required")));
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Password are Required")));
    } else {
      var loginData = FormData.fromMap({
        'npm': username,
        'password': password,
      });

      try {
        setState(() {
          isLoading = true;
        });
        dio.options.headers['content-Type'] = 'application/json';
        var response = await dio.post(cs.loginUrl, data: loginData);
        if (response.statusCode == 200) {
          if (response.data['success'] == true) {
            String bearerToken = response.data['token'];

            Map<String, dynamic> map =
                response.data['user'] as Map<String, dynamic>;
            ActiveUser au = ActiveUser.fromJson(map);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(cs.spTokenKey, bearerToken);
            await prefs.setString(cs.spActiveUser, jsonEncode(au));
            await prefs.setBool(cs.spIsLogin, true);
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const HomePage(),
                    type: PageTransitionType.bottomToTop));
          } else {
            Fluttertoast.showToast(msg: response.data['message']);
          }
        } else {
          Fluttertoast.showToast(msg: "Http Request Error !");
        }
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void checkIsButtonEnable() {
    var username = usernameController.text;
    var password = passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        isButtonEnable = false;
      });
    } else {
      setState(() {
        isButtonEnable = true;
      });
    }
  }

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
                Image.asset(
                  cs.mainLogo,
                  height: deviceWidth * 0.2,
                  width: 100,
                ),
                SizedBox(height: deviceHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text("Mobile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    const Text("SISFO",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 147, 0, 1),
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                const Text("Universitas Islam Bandung",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ],
            )),
        SizedBox(height: deviceHeight * 0.05),
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: deviceHeight * 0.01),
        Container(
          padding: const EdgeInsets.all(10),
          child: Card(
            elevation: 5,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  // decoration: BoxDecoration(
                  //     border:
                  //         Border(bottom: BorderSide(col
                  //         chior: Colors.grey[200]!))),
                  child: TextField(
                    onChanged: (value) {
                      checkIsButtonEnable();
                    },
                    // onEditingComplete: () => checkIsButtonEnable(),
                    controller: usernameController,
                    inputFormatters: [LengthLimitingTextInputFormatter(20)],
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none,
                        labelText: "Student ID",
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value) {
                      checkIsButtonEnable();
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.key),
                        suffixIcon: isObesecurePassword
                            ? IconButton(
                                onPressed: () => setObsecurePassword(false),
                                icon: const Icon(Icons.visibility_off))
                            : IconButton(
                                onPressed: () => setObsecurePassword(true),
                                icon: const Icon(Icons.remove_red_eye)),
                        border: InputBorder.none,
                        labelText: "Password",
                        hintStyle: const TextStyle(color: Colors.grey)),
                    obscureText: isObesecurePassword,
                  ),
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => Fluttertoast.showToast(msg: "Forgot Password"),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
        Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: isLoading
                ? const SpinKitChasingDots(color: Colors.blue)
                : MaterialButton(
                    disabledColor: Colors.grey,
                    height: 50.0,
                    minWidth: deviceWidth,
                    color: isButtonEnable ? Colors.blue : Colors.grey,
                    textColor: Colors.white,
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () => {isButtonEnable ? loginAction() : null},
                    splashColor: Colors.white,
                  )),
      ],
    ));
  }
}
