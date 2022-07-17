import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:sehatmand/screens/home_screen.dart';
import 'package:sehatmand/screens/past_exercises_screen.dart';
import 'package:sehatmand/screens/test_screen.dart';
import 'package:sehatmand/screens/mainscreen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    HomeScreen(),
    TabScreen(),
    PastExercisesScreen(),
    TestScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: tabItems[_selectedIndex],
      ),
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: Colors.deepPurpleAccent,
        animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        showElevation: false, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.7),
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          FlashyTabBarItem(
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.7),
            icon: Icon(Icons.people),
            title: Text('Friends'),
          ),
          FlashyTabBarItem(
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.7),
            icon: Icon(Icons.trending_up),
            title: Text('Progress'),
          ),
          FlashyTabBarItem(
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.7),
            icon: Icon(Icons.person),
            title: Text('My profile'),
          ),
          // FlashyTabBarItem(
          //   icon: Icon(Icons.settings),
          //   title: Text('한국어'),
          // ),
        ],
      ),
    );
  }
}
