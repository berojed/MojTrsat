import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/canteen.dart';
import 'package:mojtrsat/data/repositories/canteen_repository.dart';
import 'package:mojtrsat/providers/providers.dart';

final canteenRepositoryProvider = Provider<CanteenRepository>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return CanteenRepository(supabaseClient);
});

final canteenProvider = FutureProvider<Canteen?>((ref) async {
  final canteenRepository = ref.watch(canteenRepositoryProvider);
  return canteenRepository.getCanteen();
});