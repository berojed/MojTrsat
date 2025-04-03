import 'package:flutter/material.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Registrationviewmodel extends ChangeNotifier {
  final AuthRepository authRepository;
  final SupabaseClient supabaseClient = Supabase.instance.client;

  Registrationviewmodel({required this.authRepository});

  bool isLoading = false;
  String? errorMessage;

  Future<bool> signup(
      BuildContext context, String email, String password) async {
    //myb needs getters and setters needed for this
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      final response = await authRepository.signUp(email, password);

      return response?.user != null;
    } catch (e) {
      throw errorMessage.toString();
    } finally {
      isLoading = false;
      notifyListeners();
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
}
