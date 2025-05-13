import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionNotifier extends StateNotifier<Session?> {
  final SupabaseClient _supabaseClient;

  // Constructor that initializes the state with the current session and listens for auth state changes
  SessionNotifier(this._supabaseClient)
      : super(_supabaseClient.auth.currentSession) {
    _supabaseClient.auth.onAuthStateChange.listen((data) {
      state = data.session;
    });
  }
}
