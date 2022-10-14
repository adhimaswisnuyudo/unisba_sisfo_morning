import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unisba_sisfo/config/constanta.dart' as cs;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;
    Future<void> getData() async {
      prefs = await SharedPreferences.getInstance();
      var activeUser = prefs.getString(cs.spActiveUser);
      String user = jsonDecode(activeUser!);
      print(user);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
