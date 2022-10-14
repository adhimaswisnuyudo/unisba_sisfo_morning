import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unisba_sisfo/config/constanta.dart' as cs;
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
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(cs.mainLogo, height: 50),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      bottomNavigationBar: MainMenu(),
      body: const Center(),
    );
  }
}
