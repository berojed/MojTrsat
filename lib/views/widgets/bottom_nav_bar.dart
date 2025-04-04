import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mojtrsat/views/screens/home_screen.dart';
import 'package:mojtrsat/views/screens/settings_screen.dart';

class BottomNavigationNotifier extends StateNotifier<int> {
  BottomNavigationNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

final bottomNavigationProvider = StateNotifierProvider<BottomNavigationNotifier, int>((ref) {
  return BottomNavigationNotifier();
});


class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider);

    // Screens for bottom nav bar
    final List<Widget> pages = [
      HomeScreen(),
      SettingsScreen(),
    ];

    return Stack(
      children: [
        pages[selectedIndex],
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
            index: selectedIndex,
            onTap: (index) {
              ref.read(bottomNavigationProvider.notifier).setIndex(index);
            },
          ),
        ),
      ],
    );
  }
}
