import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mojtrsat/views/screens/canteen_screen.dart';
import 'package:mojtrsat/views/screens/home_screen.dart';
import 'package:mojtrsat/views/screens/settings_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;


  //Screens for bottom nav bar
  final List<Widget> _pages = [
    HomeScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _pages[_selectedIndex], 
        Align(
          alignment: Alignment.bottomCenter,
          child: CurvedNavigationBar(
            backgroundColor: Colors.transparent, 
            color: Colors.white, 
            buttonBackgroundColor: Colors.blueAccent, 
            height: 60,
            items: <Widget>[
              Icon(Icons.home, size: 30, color: Colors.black),
              Icon(Icons.settings, size: 30, color: Colors.black),
            ],
            index: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }
}
