import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';

class RegistrationViewModel extends StateNotifier<bool> {
  final AuthRepository authRepository;

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
}
