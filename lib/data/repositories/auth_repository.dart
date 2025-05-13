import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient supabaseClient;

  AuthRepository(this.supabaseClient) ;

  // Method to sign in a user with email and password
  Future<AuthResponse?> signIn(String email, String password) async {
    try {
      return await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      throw e.toString();
    }
  }

  // Method to sign up a new user with email and password
  Future<AuthResponse?> signUp(String email, String password) async {
    try {
      return await supabaseClient.auth
          .signUp(email: email, password: password);
    } catch (e) {
      throw e.toString();
    }
  }

  // Method to sign in a user with Google auth
  Future<void> signInWithGoogle(String androidClientId) async {
  final googleSignIn = GoogleSignIn(
    clientId: androidClientId,
  );

  final googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser?.authentication;

  if (googleAuth == null || googleAuth.idToken == null || googleAuth.accessToken == null) {
    throw 'Failed to retrieve Google tokens.';
  }

  await supabaseClient.auth.signInWithIdToken(
    provider: OAuthProvider.google,
    idToken: googleAuth.idToken!,
    accessToken: googleAuth.accessToken!,
  );
}


  // Method to sign out user with Google
  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
  }

  Future<bool> isGoogleSignedIn() async {
    return GoogleSignIn().isSignedIn();
  }

  // Method to reset password if forgotten
  Future<void> resetPassword(String email) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw e.toString();
    }
  }
}

