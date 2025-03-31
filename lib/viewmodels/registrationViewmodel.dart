import 'package:flutter/material.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


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




}
