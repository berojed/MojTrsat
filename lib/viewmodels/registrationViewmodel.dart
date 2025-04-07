import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistrationViewModel extends StateNotifier<bool> {
  final AuthRepository authRepository;
  final SupabaseClient supabaseClient = Supabase.instance.client;

  RegistrationViewModel(this.authRepository) : super(false);

  bool isLoading = false;
  String? errorMessage;

  Future<bool> signup(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    state = true;

    try {
      final response = await authRepository.signUp(email, password);
      state = response?.user != null;
      return state;
    } catch (e) {
      errorMessage = e.toString();
      state = false;
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<void> signUpWithGoogle() async {
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '358673529123-ck47qdtr2tvp6b8msv56daj2a37uconm.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }
    await supabaseClient.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> signOutFromGoogle() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  Future<bool> isGoogleSignedIn() async {
    final googleSignIn = GoogleSignIn();
    return googleSignIn.isSignedIn();
  }
}
