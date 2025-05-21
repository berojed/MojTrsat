import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/gym_membership.dart';
import 'package:mojtrsat/data/repositories/gym_repository.dart';
import 'package:mojtrsat/providers/providers.dart';
import 'package:mojtrsat/viewmodels/gym_viewmodel.dart';

final gymRepositoryProvider = Provider<GymRepository>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  final userId = supabaseClient.auth.currentUser?.id;
  return GymRepository(supabaseClient,userId);
});

final gymViewModelProvider =
    StateNotifierProvider<GymViewModel, AsyncValue<GymMembership?>>((ref) {
  final repo = ref.watch(gymRepositoryProvider);
  return GymViewModel(repo);
});
