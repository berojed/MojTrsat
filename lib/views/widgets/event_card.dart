import 'package:flutter/material.dart';
import 'package:mojtrsat/data/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: ListTile(
        leading: Icon(Icons.event, color: Colors.blue),
        title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${event.description}\n${event.date.toLocal()}'),
        isThreeLine: true,
        onTap: () {
          // Otvori detalje eventa
        },
      ),
    );
  }
}