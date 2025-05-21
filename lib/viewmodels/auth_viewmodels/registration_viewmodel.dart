import 'package:mojtrsat/data/repositories/auth_repository.dart';
import 'package:mojtrsat/viewmodels/auth_viewmodels/base_auth_viewmodel.dart';

class RegistrationViewModel extends BaseAuthViewModel {

  RegistrationViewModel(AuthRepository authRepository) : super(authRepository, authRepository.supabaseClient);

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

    Future<bool> uniriSignIn(String uniriEmail) async {
    try {
      final response = await authRepository.uniriSignIn(uniriEmail);
      return response;
    } catch (e) {
      return false;
    }
  }


}
