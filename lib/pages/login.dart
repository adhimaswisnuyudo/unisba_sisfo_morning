import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unisba_sisfo/config/constanta.dart' as cs;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObesecurePassword = true;
  bool isButtonEnable = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void setObsecurePassword(bool val) {
    setState(() {
      isObesecurePassword = val;
    });
  }

  void loginAction() {
    var username = usernameController.text;
    var password = passwordController.text;
    if (username.isEmpty || username.length < 1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Student ID are Required")));
    } else if (password.isEmpty || password.length < 1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Password are Required")));
    } else {
      Fluttertoast.showToast(msg: "Login OK");
    }
  }

  void checkIsButtonEnable() {
    var username = usernameController.text;
    var password = passwordController.text;
    if (username.isEmpty || username.length < 1) {
      setState(() {
        isButtonEnable = false;
      });
    } else if (password.isEmpty || password.length < 1) {
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
        SizedBox(height: deviceHeight * 0.05),
        Container(
          padding: EdgeInsets.only(left: 20),
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
                    onChanged: (value) {
                      checkIsButtonEnable();
                    },
                    // onEditingComplete: () => checkIsButtonEnable(),
                    controller: usernameController,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none,
                        labelText: "Student ID",
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value) {
                      checkIsButtonEnable();
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: isObesecurePassword
                            ? IconButton(
                                onPressed: () => setObsecurePassword(false),
                                icon: Icon(Icons.visibility_off))
                            : IconButton(
                                onPressed: () => setObsecurePassword(true),
                                icon: Icon(Icons.remove_red_eye)),
                        border: InputBorder.none,
                        labelText: "Password",
                        hintStyle: TextStyle(color: Colors.grey)),
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
            padding: EdgeInsets.only(right: 10, left: 10),
            child: MaterialButton(
              disabledColor: Colors.grey,
              height: 50.0,
              minWidth: deviceWidth,
              color: isButtonEnable ? Colors.blue : Colors.grey,
              textColor: Colors.white,
              child: Text(
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
