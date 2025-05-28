import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/chatmessage.dart';
import 'package:mojtrsat/data/models/laundry.dart';
import 'package:mojtrsat/viewmodels/chat_viewmodel.dart';
import 'package:mojtrsat/viewmodels/laundry_viewmodel.dart';
import 'package:mojtrsat/views/widgets/bottom_nav_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final currentUserProvider = Provider<String?>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return supabase.auth.currentUser?.id;
});

final bottomNavigationProvider =
    StateNotifierProvider<BottomNavigationNotifier, int>((ref) {
  return BottomNavigationNotifier();
});


final chatViewModelProvider =
    StateNotifierProvider<ChatViewModel, List<Chatmessage>>((ref) {
  return ChatViewModel(ref.watch(supabaseClientProvider));
});

final laundryViewModelProvider =
    StateNotifierProvider<Laundryviewmodel, List<Laundry>>((ref) {
  return Laundryviewmodel(ref.watch(supabaseClientProvider));
});


