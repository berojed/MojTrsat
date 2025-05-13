// This class will handle the data layer for the canteen
  // It will interact with the database to fetch canteen data
  // and provide it to the rest of the application.

import 'package:mojtrsat/data/models/canteen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CanteenRepository{

  final SupabaseClient _supabaseClient;

  CanteenRepository(this._supabaseClient);


  // Fetch the canteen data from the database
  // This method will return a Canteen object or null if there was an error
  // or if the canteen data does not exist.
  
  Future<Canteen?> getCanteen() async {
    try {
      final response = await _supabaseClient.from('canteen').select().eq('canteen_id', 1).single();
      return Canteen.fromJson(response);
        } catch (e) {
      print("Error fetching canteen data: $e");
      return null;
    }

   
  }
  
}