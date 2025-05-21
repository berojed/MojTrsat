import 'package:flutter/material.dart';

class Event {
  final String title;
  final String date;
  final String imagePath;
  final Color bgColor;
  final List<String> attendees; // ili User objekti

  Event({
    required this.title,
    required this.date,
    required this.imagePath,
    required this.bgColor,
    this.attendees = const [],
  });
}

class EventsScreen extends StatelessWidget {
  final List<Event> events = [
    Event(
      title: 'Nogometna utakmica',
      date: 'Petak, 21.06. u 19:00',
      imagePath: 'assets/images/flutter_logo.png',
      bgColor: Color(0xFF22534C),
      attendees: ['Ana', 'Ivan', 'Petar'],
    ),
    Event(
      title: 'Party u domu',
      date: 'Subota, 22.06. u 21:00',
      imagePath: 'assets/images/flutter_logo.png',
      bgColor: Color(0xFFB83A2E),
      attendees: ['Maja', 'Filip'],
    ),
    Event(
      title: 'Planinarenje na Učku',
      date: 'Nedjelja, 23.06. u 8:00',
      imagePath: 'assets/images/flutter_logo.png',
      bgColor: Color(0xFF2E4CB8),
      attendees: ['Martina', 'Dario'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventovi', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              // TODO: Dodaj novi event (modal/screen)
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        children: [
          Text('Preporučeni eventovi', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 14),
          ...events.map((event) => _EventCard(event: event)).toList(),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final Event event;

  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Otvori detalje eventa
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => EventDetailsScreen(event: event),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: event.bgColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: event.bgColor.withOpacity(0.1), blurRadius: 14, spreadRadius: 2)],
        ),
        height: 130,
        child: Row(
          children: [
            // Event slika
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(event.imagePath, height: 80, width: 80, fit: BoxFit.contain),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(event.date, style: TextStyle(fontSize: 15, color: Colors.white70)),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.people, color: Colors.white70, size: 16),
                        SizedBox(width: 4),
                        Text('${event.attendees.length} prijavljeno', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Ikona "like" ili favorite po želji
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.favorite_border, color: Colors.white, size: 24),
            )
          ],
        ),
      ),
    );
  }
}

class EventDetailsScreen extends StatelessWidget {
  final Event event;
  const EventDetailsScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: event.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gornja kartica
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: event.bgColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12)],
            ),
            child: Row(
              children: [
                Image.asset(event.imagePath, height: 65),
                SizedBox(width: 14),
                Expanded(
                  child: Text(event.title, style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          // Datum i vrijeme
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            child: Text(event.date, style: TextStyle(color: Colors.white70, fontSize: 16)),
          ),
          SizedBox(height: 20),
          // Gumbi za prijavu/odjavu na event (dummy logic)
          Center(
            child: ElevatedButton(
              onPressed: () {
                // TODO: Prijava na event (backend)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: event.bgColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.symmetric(horizontal: 34, vertical: 14),
              ),
              child: Text('PRIJAVI SE NA EVENT', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: 24),
          // Tko ide na event
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text('Prijavljeni:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Wrap(
              spacing: 10,
              children: event.attendees.map((attendee) => Chip(
                label: Text(attendee, style: TextStyle(color: event.bgColor, fontWeight: FontWeight.w600)),
                backgroundColor: Colors.white,
              )).toList(),
            ),
          ),
          Spacer(),
          // Gumb za otkazati event (samo ako si owner/admin)
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: OutlinedButton(
              onPressed: () {
                // TODO: Otkazivanje eventa
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Center(child: Text('OTKAŽI EVENT', style: TextStyle(color: Colors.white))),
            ),
          )
        ],
      ),
    );
  }
}
