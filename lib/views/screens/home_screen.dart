import 'package:flutter/material.dart';
import 'package:mojtrsat/data/viewmodels/homeViewModel.dart';
import 'package:mojtrsat/views/screens/settings_screen.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final homeviewmodel = Provider.of<Homeviewmodel>(context);

    final List<Widget> pages = [
      HomeScreen(), 
      SettingsScreen(), 
    ];

    return Scaffold(
      backgroundColor: Colors.white, 
      body: pages[homeviewmodel.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1E1E1E),
        currentIndex: homeviewmodel.selectedIndex,
        onTap: homeviewmodel.changePage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Početna'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Postavke'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Text("Bok, Bernard!",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
          SizedBox(height: 10),
          Card(
            color: Color(0xFF1E1E1E),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Potrošeno danas:",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(height: 5),
                  Text("3 / 5.5 \$",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
