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
  Future<void> signInWithGoogle(String webClientId) async {

    try {
    final googleSignIn = GoogleSignIn(
    clientId: webClientId
  );

  final googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser?.authentication;

  if (googleAuth == null || googleAuth.idToken == null || googleAuth.accessToken == null) {
    throw 'Failed to retrieve Google tokens.';
  }

  final response = await supabaseClient.auth.signInWithIdToken(
    provider: OAuthProvider.google,
    idToken: googleAuth.idToken!,
    accessToken: googleAuth.accessToken!,
  );

    } catch (e) {
       print("Error: $e");
    }
 

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

  Future<bool> userExists(String userID) async {
    try {
      final response = await supabaseClient
          .from('users')
          .select()
          .eq('userid', userID)
          .maybeSingle();

      
      return response != null;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> uniriSignIn(String uniriEmail) async {
    try {
      final user = supabaseClient.auth.currentUser;

      await supabaseClient.from('users').upsert({
        'userid': user?.id,
        'email': user?.email,
        'uniri_email': uniriEmail,

      });

      return true;
      
    } catch (e) {
      throw e.toString();
    }
  }
}

