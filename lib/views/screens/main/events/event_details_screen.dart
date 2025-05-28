import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/providers/events_provider.dart';
import 'package:mojtrsat/providers/providers.dart';

class EventDetailsScreen extends ConsumerWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsViewModelProvider);
    final currentUserId = ref.watch(currentUserProvider);

    
    final eventId = ref.watch(selectedEventIdProvider);

    final event = eventsAsync.maybeWhen(
      data: (events) {
        try {
          return events.firstWhere((e) => e.eventID == eventId);
        } catch (_) {
          return null;
        }
      },
      orElse: () => null,
    );

    if (event == null || currentUserId == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final eventsViewModel = ref.read(eventsViewModelProvider.notifier);
    final isGoing = event.attendees.contains(currentUserId);

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            event.title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: isGoing ? Colors.red : Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              icon: Icon(isGoing ? Icons.close : Icons.check),
              label: Text(isGoing ? "Otkaži prijavu" : "Prijavi se na event"),
              onPressed: () async {
                if (isGoing) {
                  await eventsViewModel.leaveEvent(event, currentUserId);
                } else {
                  await eventsViewModel.joinEvent(event, currentUserId);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
