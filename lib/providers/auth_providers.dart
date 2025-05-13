import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';
import 'package:mojtrsat/data/repositories/auth_session.dart';
import 'package:mojtrsat/providers/providers.dart';
import 'package:mojtrsat/viewmodels/auth_viewmodels/login_viewmodel.dart';
import 'package:mojtrsat/viewmodels/auth_viewmodels/registration_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sessionProvider = StateNotifierProvider<SessionNotifier,Session?>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SessionNotifier(supabaseClient);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return AuthRepository(supabaseClient);
});

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, bool>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginViewModel(authRepository);
});

final registrationViewModelProvider =
    StateNotifierProvider<RegistrationViewModel, bool>((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
  return RegistrationViewModel(authRepository);
});