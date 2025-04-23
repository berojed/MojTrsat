import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/canteen.dart';
import 'package:mojtrsat/data/models/chatmessage.dart';
import 'package:mojtrsat/data/models/laundry.dart';
import 'package:mojtrsat/data/models/news_article.dart';
import 'package:mojtrsat/data/models/student.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';
import 'package:mojtrsat/viewmodels/chatViewModel.dart';
import 'package:mojtrsat/viewmodels/homeViewModels.dart';
import 'package:mojtrsat/viewmodels/laundryViewmodel.dart';
import 'package:mojtrsat/viewmodels/loginViewmodel.dart';
import 'package:mojtrsat/viewmodels/registrationViewmodel.dart';
import 'package:mojtrsat/views/widgets/bottom_nav_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, bool>((ref) {
  return LoginViewModel(ref.watch(authRepositoryProvider));
});

final registrationViewModelProvider =
    StateNotifierProvider<RegistrationViewModel, bool>((ref) {
  return RegistrationViewModel(ref.watch(authRepositoryProvider));
});

final bottomNavigationProvider =
    StateNotifierProvider<BottomNavigationNotifier, int>((ref) {
  return BottomNavigationNotifier();
});

final canteenViewModelProvider =
    StateNotifierProvider<CanteenViewModel, AsyncValue<Canteen?>>((ref) {
  return CanteenViewModel(ref.watch(supabaseClientProvider));
});

final newsViewModelProvider =
    StateNotifierProvider<NewsViewModel, List<NewsArticle?>>((ref) {
  return NewsViewModel(ref.watch(supabaseClientProvider));
});

final studentViewModelProvider =
    StateNotifierProvider<StudentViewModel, AsyncValue<Student?>>((ref) {
  return StudentViewModel(ref.watch(supabaseClientProvider));
});

final chatViewModelProvider =
    StateNotifierProvider<ChatViewModel, List<Chatmessage>>((ref) {
  return ChatViewModel(ref.watch(supabaseClientProvider));
});

final laundryViewModelProvider =
    StateNotifierProvider<Laundryviewmodel, List<Laundry>>((ref) {
  return Laundryviewmodel(ref.watch(supabaseClientProvider));
});
