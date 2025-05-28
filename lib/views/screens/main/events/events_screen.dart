import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mojtrsat/providers/events_provider.dart';
import 'package:mojtrsat/views/widgets/event_card.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventovi', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              context.push('/events/add_event');
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: eventsAsync.when(
        data: (events) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: events.length,
          itemBuilder: (context, idx) => GestureDetector(
            onTap: () {
              ref.read(selectedEventIdProvider.notifier).state =
                  events[idx].eventID;
              context.push('/events/details');
            },
            child: EventCard(event: events[idx]),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) =>
            Center(child: Text('Greška pri učitavanju eventova: $e')),
      ),
    );
  }
}
