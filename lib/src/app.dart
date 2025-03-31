import 'package:flutter/material.dart';
import 'package:mojtrsat/views/screens/login_screen.dart';
import 'package:mojtrsat/views/widgets/bottom_nav_bar.dart';
import 'package:mojtrsat/views/screens/canteen_screen.dart';
import 'package:mojtrsat/views/screens/registration_screen.dart';
import 'package:mojtrsat/views/screens/settings_screen.dart';


/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Poppins"),
      darkTheme: ThemeData.dark(),
      initialRoute: '/login',
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/registration': (context) => RegistrationScreen(),
        '/home': (context) => BottomNavigation(),
        '/settings': (context) => SettingsScreen(),
        '/canteen' : (context) => CanteenScreen(),
      },
    );
  }
}
