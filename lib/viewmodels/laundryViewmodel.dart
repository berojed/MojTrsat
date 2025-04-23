import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mojtrsat/data/models/laundry.dart';
import 'package:uuid/uuid.dart';

class Laundryviewmodel extends StateNotifier<List<Laundry>> {
  final SupabaseClient _supabase;

  Laundryviewmodel(this._supabase) : super([]);

  Future<bool> createLaundrySlot(
      String machineID, String timeSlot, String dayOfTheWeek) async {
    String reservationTime = timeSlot + " " + dayOfTheWeek; //e.g. 0:00 Mon
    final uuid = Uuid();
    final newUUID = uuid.v4();
    //final response = await fetchLaundrySlot(machineID, timeSlot, dayOfTheWeek);
    //if (response!.isNotEmpty) return false;

    try {
      await _supabase.from('laundry').insert({
        'laundryid': newUUID,
        'machineid': machineID,
        'availability': 0,
        'reservationtime': reservationTime
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Map<String, dynamic>>?> fetchLaundrySlot(
      String machineID, String timeSlot, String dayOfTheWeek) async {
    String reservationTime = timeSlot + " " + dayOfTheWeek;
    try {
      final response = await _supabase.from('users').select().match({
        'machineid': machineID,
        'reservationtime': reservationTime,
        'availability': 1
      });

      if (response.isNotEmpty) return response;
    } catch (e) {
      print(e);
      return [];
    }
    return [];
  }
}
