import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';

class LoginViewModel extends StateNotifier<bool> {
  final AuthRepository authRepository;

  LoginViewModel(this.authRepository) : super(false);

  bool isLoading = false;
  String? errorMessage;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    state = true;

    try {
      final response = await authRepository.signIn(email, password);
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


}
