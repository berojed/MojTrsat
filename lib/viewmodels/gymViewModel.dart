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

      if (response == null || response['membershipType'] == null) {
        state = const AsyncValue.data(null);
        return;
      } 

      final membership = GymMembership.fromJson(response);
        state = AsyncValue.data(membership);

    } catch (e,st) {
      print('Error fetching gym memberships: $e');
      state = AsyncValue.error(e,st);
    }
  }

  Future<void> addGymMembership(GymMembership membership) async {

    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      print('User ID is null. Cannot add gym membership.');
      return;
    }

    try {
      
      final response = await _supabase
          .from('gym')
          .insert(membership.toJson())
          .eq('userid', userId);

      if (response.isEmpty) {
         await _supabase.from('gym').insert(membership.toJson());
        
      } 
      state = AsyncValue.data(membership);
    } catch (e) {
      print('Error adding gym membership: $e');
    }
  }

  Future<void> removeGymMembership() async {

    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      print('User ID is null. Cannot remove gym membership.');
      return;
    }

    try {
      
      await _supabase.from('gym').update({
        'membershipLength': null,
        'membershipDaysLeft': null,
        'membershipType': null,
      }).eq('userID', userId!);

      state = const AsyncValue.data(null);
    } catch (e) {
      print('Error removing gym membership: $e');
    }
  }
}
