import 'package:flutter/material.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';
import 'package:mojtrsat/data/viewmodels/homeViewModel.dart';
import 'package:mojtrsat/data/viewmodels/loginViewmodel.dart';
import 'package:mojtrsat/data/viewmodels/registrationViewmodel.dart';
import 'package:mojtrsat/src/app.dart';

import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://rvakgykjjphhzrerasjt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ2YWtneWtqanBoaHpyZXJhc2p0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc5OTQ4NjYsImV4cCI6MjA1MzU3MDg2Nn0.XraLhmZHo8qr1J7Q6u5jMp-Ulp2AV0ORq9u7iocwFA0',
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) =>
              LoginViewmodel(authRepository: AuthRepository())),
      ChangeNotifierProvider(
          create: (context) =>
              Registrationviewmodel(authRepository: AuthRepository())),
      ChangeNotifierProvider(create: (_) => Homeviewmodel())
    ],
    child: MyApp(),
  ));
}
