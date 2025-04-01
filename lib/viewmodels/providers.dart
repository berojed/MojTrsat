import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/canteen.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';
import 'package:mojtrsat/viewmodels/homeViewModel.dart';
import 'package:mojtrsat/viewmodels/loginViewmodel.dart';
import 'package:mojtrsat/viewmodels/registrationViewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Define a provider for the Supabase client
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// Define a provider for the AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Define a provider for the HomeViewModel
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, AsyncValue<Canteen?>>((ref) {
  return HomeViewModel(ref.watch(supabaseClientProvider));
});

// Define a provider for the LoginViewModel
final loginViewModelProvider = StateNotifierProvider<LoginViewModel, bool>((ref) {
  return LoginViewModel(ref.watch(authRepositoryProvider));
});

// Define a provider for the RegistrationViewModel
final registrationViewModelProvider = StateNotifierProvider<RegistrationViewModel,bool>((ref) {
  return RegistrationViewModel(ref.watch(authRepositoryProvider));
});
