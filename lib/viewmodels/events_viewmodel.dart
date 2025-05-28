import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/event.dart';
import 'package:mojtrsat/data/repositories/events_repository.dart';

class EventViewModel extends StateNotifier<AsyncValue<List<Event>>> {

  final EventsRepository eventsRepository;

  EventViewModel(this.eventsRepository) : super(const AsyncValue.loading()) {
    fetchEvents();
  }

  // Method to fetch available events
  Future<void> fetchEvents() async {
    try {
      
      state = const AsyncValue.loading();
      final events = await eventsRepository.fetchEvents();

      state = AsyncValue.data(events);
    } catch (e, st) {
      print('Error fetching events: $e');
      state = AsyncValue.error(e, st);
    }
  }

  // Method to create an empty gym membership
  // This is used when a user signs up and we want to create an empty membership
  Future<bool> createEvent(Event event) async {
    try {
      await eventsRepository.addEvent(event);
      await eventsRepository.fetchEvents();
      return true;
    } catch (e,st) {
      print('Error creating empty membership: $e');
      state = AsyncValue.error(e,st);
      return false;
    }
  }

   Future<void> joinEvent(Event event, String userId) async {

    await eventsRepository.joinEvent(event, userId);
    
    
  }

  Future<void> leaveEvent(Event event, String userId) async {
    
    await eventsRepository.leaveEvent(event, userId);
  }

 

  

}
