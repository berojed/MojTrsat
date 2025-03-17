import 'package:flutter/material.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';


class LoginViewmodel extends ChangeNotifier {
  final AuthRepository authRepository;

  LoginViewmodel({required this.authRepository});

  bool isLoading = false;
  String? errorMessage;

 

  Future<void> login(String email, String password) async {

    //myb needs getters and setters needed for this
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {

      await authRepository.signIn(email, password);
     
    } catch (e) {
      throw errorMessage.toString();
      
    }
    finally{
      isLoading=false;
      notifyListeners();
    }


  }
}
