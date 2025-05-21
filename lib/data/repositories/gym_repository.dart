import 'package:intl/intl.dart';
import 'package:mojtrsat/data/models/gym_membership.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GymRepository {
  // This class will handle the data operations related to gyms.
  // It will interact with the database or any other data source.

  final SupabaseClient _supabaseClient;
  final String? userId;

  GymRepository(this._supabaseClient, this.userId);

  // Example method to fetch gym details
  Future<GymMembership?> getGymDetails() async {
    if (userId == null) {
      throw Exception('User not logged in');
    }

    final response = await _supabaseClient
        .from('gym')
        .select()
        .eq('userID', userId as Object)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return GymMembership.fromJson(response);
  }

  Future<void> addGymMembership(GymMembership membership) async {
    if (userId == null) {
      throw Exception('User not logged in');
    }

    await _supabaseClient.from('gym').upsert(membership.toJson());
  }

  Future<void> addGymMembershipAgain(
      String membershipType, int membershipLength) async {
    if (userId == null) {
      throw Exception('User not logged in');
    }

    final response = await _supabaseClient
        .from('gym')
        .select()
        .eq('userID', userId as Object)
        .maybeSingle();

    if (response == null) {
      throw Exception('No gym membership found for this user');
    }

    final currentMembership = GymMembership.fromJson(response);

    final dateBought = DateFormat('dd/MM/yyyy').format(DateTime.now());
    final newEntry = "$membershipType - Kupljeno: $dateBought";
    final updatedHistory = [...currentMembership.membershipHistory, newEntry];

    await _supabaseClient.from('gym').update({
      'membershipHistory': updatedHistory,
      'membershipType': membershipType,
      'membershipLength': membershipLength,
    }).eq('userID', userId as Object);
  }

  Future<void> removeGymMembership() async {
    if (userId == null) {
      throw Exception('User not logged in');
    }

    await _supabaseClient.from('gym').update({
      'membershipType': null,
      'membershipLength': null,
    }).eq('userID', userId as Object);
  }
}
