import 'package:flutter/material.dart';
import 'package:mojtrsat/views/screens/login_and_registration/forgot_password.dart';
import 'package:mojtrsat/views/screens/login_and_registration/user_session.dart';
import 'package:mojtrsat/views/screens/main/chat_screen.dart';
import 'package:mojtrsat/views/screens/main/gym_screen.dart';
import 'package:mojtrsat/views/screens/main/laundry_screen.dart';
import 'package:mojtrsat/views/screens/login_and_registration/login_screen.dart';
import 'package:mojtrsat/views/screens/main/main_screen.dart';
import 'package:mojtrsat/views/screens/main/reservations_screen.dart';
import 'package:mojtrsat/views/screens/home/canteen_screen.dart';
import 'package:mojtrsat/views/screens/login_and_registration/registration_screen.dart';
import 'package:mojtrsat/views/screens/settings/settings_screen.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    initialLocation: '/session', 
    routes: [
      GoRoute(path: '/session', builder: (context, state) => UserSession()),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/registration',builder: (context, state) => RegistrationScreen()),
      GoRoute(path: '/settings', builder: (context, state) => SettingsScreen()),
      GoRoute(path: '/canteen', builder: (context, state) => CanteenScreen()),
      GoRoute(path: '/main', builder: (context, state) => MainScreen()),
      GoRoute(path: '/chat', builder: (context, state) => WholeChatScreen()),
      GoRoute(path: '/individual_chat', builder: (context, state) => ChatScreen()),
      GoRoute(path: '/reservations',builder: (context, state) => ReservationsScreen()),
      GoRoute(path: '/laundry',builder: (context, state) => LaundryScreen()),
      GoRoute(path: '/gym', builder: (context, state) => GymScreen()),
      GoRoute(path: '/reset_password', builder: (context, state) => ForgotPasswordScreen()),
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
