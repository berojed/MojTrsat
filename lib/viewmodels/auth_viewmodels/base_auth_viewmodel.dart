import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


abstract class BaseAuthViewModel extends StateNotifier<bool> {
  final AuthRepository authRepository;
  final SupabaseClient supabaseClient;

  BaseAuthViewModel(this.authRepository, this.supabaseClient) : super(false);

  bool isLoading = false;
  String? errorMessage;
  
  String webClientId = dotenv.env['WEB_CLIENT_ID']!;

  Future<void> signUpWithGoogle() async {
    await authRepository.signInWithGoogle(webClientId);
  }

  Future<void> signOutFromGoogle() async {
    await authRepository.signOutGoogle();
  }

  Future<bool> isGoogleSignedIn() async {
    return await authRepository.isGoogleSignedIn();
  }
}
