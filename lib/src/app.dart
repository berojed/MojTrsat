import 'package:flutter/material.dart';
import 'package:mojtrsat/views/screens/laundry_screen.dart';
import 'package:mojtrsat/views/screens/login_screen.dart';
import 'package:mojtrsat/views/screens/main_screen.dart';
import 'package:mojtrsat/views/screens/reservations_screen.dart';
import 'package:mojtrsat/views/widgets/bottom_nav_bar.dart';
import 'package:mojtrsat/views/screens/canteen_screen.dart';
import 'package:mojtrsat/views/screens/registration_screen.dart';
import 'package:mojtrsat/views/screens/settings_screen.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    initialLocation: '/main/reservations/laundry',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(
          path: '/registration',
          builder: (context, state) => RegistrationScreen()),
      GoRoute(path: '/home', builder: (context, state) => BottomNavigation()),
      GoRoute(path: '/settings', builder: (context, state) => SettingsScreen()),
      GoRoute(path: '/canteen', builder: (context, state) => CanteenScreen()),
      GoRoute(path: '/main', builder: (context, state) => MainScreen()),
      GoRoute(
        path: '/main/reservations',
        builder: (context, state) => ReservationsScreen(),
      ),
      GoRoute(
        path: '/main/reservations/laundry',
        builder: (context, state) => LaundryScreen(),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
