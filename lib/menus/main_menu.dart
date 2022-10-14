import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:unisba_sisfo/pages/login.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int selectedPos = 0;
  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of([
    TabItem(Icons.home, "Home", Colors.blue),
    TabItem(Icons.list, "Schedule", Colors.blue),
    TabItem(Icons.check, "Attendance", Colors.blue),
    TabItem(Icons.mail, "Activity", Colors.blue),
    TabItem(Icons.person, "Account", Colors.blue),
  ]);

  late CircularBottomNavigationController _navigationController;
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos!;
          // Navigator.pushReplacement(
          //     context,
          //     PageTransition(
          //         child: const LoginPage(),
          //         type: PageTransitionType.bottomToTop));
        });
      },
    );
  }
}
