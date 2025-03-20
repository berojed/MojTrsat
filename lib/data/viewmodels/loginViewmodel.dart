import 'package:flutter/material.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';
import 'package:mojtrsat/views/screens/registration_screen.dart';

class LoginViewmodel extends ChangeNotifier {
  final AuthRepository authRepository;

  LoginViewmodel({required this.authRepository});

  bool isLoading = false;
  String? errorMessage;

  Future<bool> login(
      BuildContext context, String email, String password) async {
    //myb needs getters and setters needed for this
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      final response = await authRepository.signIn(email, password);

      return response?.user != null;
    } 
    
    //failed login
    catch (e) {
      throw errorMessage.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void navigateToRegistrationScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RegistrationScreen()));
  }
}
