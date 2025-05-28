import 'package:mojtrsat/data/models/event.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EventsRepository {

  final SupabaseClient _supabaseClient;

  EventsRepository(this._supabaseClient);

  //Function that fetch all available events
  Future<List<Event>> fetchEvents () async {

    final response = await _supabaseClient.from('events').select().order('date',ascending: true);

    if(response.isEmpty) return [];

    return (response as List).map((e) => Event.fromJson(e as Map<String,dynamic>)).toList();

  }

  Future<void> addEvent(Event event) async {

    final response= await _supabaseClient.from('events').insert(event.toJson());

    if(response.hashCode==200)
    {
      print('Dodali smo event');
    }
  }


  Future<void> deleteEvent(String eventID) async {
    final response= await _supabaseClient.from('events').delete().eq('eventID', eventID);

    if(response.hashCode==300) print('Cant delete event');
  }

  // I had to create new list of attendees(with new attendee) and then replace it with old one 
  Future<void> joinEvent(Event event, String userId) async {
    final updatedAttendees = List<String>.from(event.attendees);
    if(!updatedAttendees.contains(userId))
    {

      updatedAttendees.add(userId);
      await _supabaseClient.from('events').update({'attendees' : updatedAttendees }).eq('eventID', event.eventID);

    }
  }

  Future<void> leaveEvent(Event event, String userId) async{

    final updatedAttendees = List<String>.from(event.attendees);
    if(updatedAttendees.contains(userId))
    {
      updatedAttendees.remove(userId);
      await _supabaseClient.from('events').update({'attendees': updatedAttendees }).eq('eventID', event.eventID);
    }
  }


}