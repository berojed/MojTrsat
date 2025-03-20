import 'dart:ffi';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:mojtrsat/models/notification.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  Future<AuthResponse?> signIn(String email, String password) async {
    try {
      final response = supabaseClient.auth
          .signInWithPassword(email: email, password: password);

      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<AuthResponse?> signUp(String email, String password) async {
    try {
      final response =
          supabaseClient.auth.signUp(email: email, password: password);

      return response;
    } catch (e) {
      throw e.toString();
    }
  }


}
