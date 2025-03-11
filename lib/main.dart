import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';







void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

    await Supabase.initialize(
    url: 'https://rvakgykjjphhzrerasjt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ2YWtneWtqanBoaHpyZXJhc2p0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc5OTQ4NjYsImV4cCI6MjA1MzU3MDg2Nn0.XraLhmZHo8qr1J7Q6u5jMp-Ulp2AV0ORq9u7iocwFA0',
  );

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));

  final supabase = Supabase.instance.client;

  print(supabase.auth.currentSession);

}



