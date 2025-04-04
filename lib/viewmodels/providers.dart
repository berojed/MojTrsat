import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/canteen.dart';
import 'package:mojtrsat/data/models/news_article.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';
import 'package:mojtrsat/viewmodels/homeViewModels.dart';
import 'package:mojtrsat/viewmodels/loginViewmodel.dart';
import 'package:mojtrsat/viewmodels/registrationViewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});


final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, bool>((ref) {
  return LoginViewModel(ref.watch(authRepositoryProvider));
});


final registrationViewModelProvider = StateNotifierProvider<RegistrationViewModel,bool>((ref) {
  return RegistrationViewModel(ref.watch(authRepositoryProvider));
});



final canteenViewModelProvider = StateNotifierProvider<CanteenViewModel, AsyncValue<Canteen?>>((ref) {
  return CanteenViewModel(ref.watch(supabaseClientProvider));
});

final newsViewModelProvider = StateNotifierProvider<NewsViewModel, List<NewsArticle?>>((ref) {
  return NewsViewModel(ref.watch(supabaseClientProvider));
});

