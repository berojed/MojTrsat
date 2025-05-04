import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/gym_membership.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GymViewModel extends StateNotifier<AsyncValue<GymMembership?>> {
  final SupabaseClient _supabase;

  GymViewModel(this._supabase) : super(const AsyncValue.loading()) {
    fetchGymMembership();
  }

  Future<void> fetchGymMembership() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        state = const AsyncValue.data(null);
        return;
      }

      final response = await _supabase
          .from('gym')
          .select()
          .eq('userID', userId)
          .maybeSingle();

      if (response == null) {
        state = const AsyncValue.data(null);
        return;
      }

      final membership = GymMembership.fromJson(response);
      state = AsyncValue.data(membership);
    } catch (e, st) {
      print('Error fetching gym membership: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createEmptyMembership(GymMembership membership) async {
    try {
      await _supabase.from('gym').insert(membership.toJson());
      state = AsyncValue.data(membership);
    } catch (e) {
      print('Error creating empty membership: $e');
    }
  }

  Future<void> addGymMembershipAgain(String membershipType, int membershipLength) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    try {
      // Fetching current membership to update membership historz
      final response = await _supabase
          .from('gym')
          .select()
          .eq('userID', userId)
          .maybeSingle();

      if (response == null) return;

      final currentMembership = GymMembership.fromJson(response);

      // Updating history of memberships
      final updatedHistory = [...currentMembership.membershipHistory, membershipType];

      final updateData = {
        'membershipType': membershipType,
        'membershipLength': membershipLength,
        'membershipHistory': updatedHistory,
        'createdAt': DateTime.now().toIso8601String(),
      };

      await _supabase.from('gym').update(updateData).eq('userID', userId);

      // Refetch
      fetchGymMembership();
    } catch (e) {
      print('Error updating membership: $e');
    }
  }

  Future<void> removeGymMembership() async {
  final userId = _supabase.auth.currentUser?.id;
  if (userId == null) return;

  try {
    await _supabase.from('gym').update({
      'membershipType': null,
      'membershipLength': null,
    }).eq('userID', userId);

    
    final updated = await _supabase
        .from('gym')
        .select()
        .eq('userID', userId)
        .maybeSingle();

    if (updated != null) {
      final newMembership = GymMembership.fromJson(updated);
      state = AsyncValue.data(newMembership);
    }
  } catch (e) {
    print('Error removing membership: $e');
  }
}

}
