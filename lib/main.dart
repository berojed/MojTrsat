import 'package:flutter/material.dart';
import 'package:mojtrsat/views/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';





void main() async {
  

    await Supabase.initialize(
    url: 'https://rvakgykjjphhzrerasjt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ2YWtneWtqanBoaHpyZXJhc2p0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc5OTQ4NjYsImV4cCI6MjA1MzU3MDg2Nn0.XraLhmZHo8qr1J7Q6u5jMp-Ulp2AV0ORq9u7iocwFA0',
  );

  runApp(MaterialApp(
    initialRoute: '/login',
    routes: 
    {

      '/login' : (context) => const LoginScreen()
      //'/registration' : (context) => const RegistrationScreen()

    }
    
  ));

  final supabase = Supabase.instance.client;


}



