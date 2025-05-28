import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/event.dart';
import 'package:mojtrsat/data/repositories/events_repository.dart';
import 'package:mojtrsat/providers/providers.dart';
import 'package:mojtrsat/viewmodels/events_viewmodel.dart';

final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  final supabaseProvider = ref.read(supabaseClientProvider);
  return EventsRepository(supabaseProvider);
});

final eventsViewModelProvider = StateNotifierProvider<EventViewModel, AsyncValue<List<Event>>>((ref) {
  final repo = ref.watch(eventsRepositoryProvider);
  return EventViewModel(repo);
});

final selectedEventIdProvider = StateProvider<String?>((ref) => null);
