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
//scopes which determine data that user can share with app
    const List<String> scopes = <String>['email'];

    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: scopes);

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      //user gave up while signing up with google
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      final String? googleToken = googleSignInAuthentication.idToken;

      if (googleToken != null) {
        final response = await supabaseClient.auth.signInWithIdToken(
            provider: OAuthProvider.google, idToken: googleToken);
      }
    } catch (e) {
      
    }
  }
}
