import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mojtrsat/data/models/laundry.dart';
import 'package:uuid/uuid.dart';

// This class will handle the data layer for the laundry reservations
// It will interact with the database to fetch laundry reservations and create new reservations
class Laundryviewmodel extends StateNotifier<List<Laundry>> {
  final SupabaseClient _supabase;
  final String userID;

  Laundryviewmodel(this._supabase) : userID = _supabase.auth.currentUser!.id, super ([]);

  Future<bool> createLaundrySlot(int machineID, String timeSlot, String dayOfTheWeek) async {
    final uuid = Uuid();
    final newUUID = uuid.v4();

    try {
      await _supabase.from('laundry').insert({
        'laundryid': newUUID,
        'machineid': machineID,
        'reservationtime': timeSlot,
        'reservationday': dayOfTheWeek,
        'userid': userID,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Map<String, dynamic>>?> fetchLaundrySlot(int machineID, String timeSlot, String dayOfTheWeek) async {

    try {
      final response = await _supabase.from('laundry').select().match({
        'machineid': machineID,
        'reservationtime': timeSlot,
        'reservationday': dayOfTheWeek,
        'userid': userID,
      });

      if (response.isNotEmpty) return response;
    } catch (e) {
      print(e);
      return [];
    }
    return [];
  }
}
