class Event {
  final String eventID;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final DateTime createdAt;
  final List<String> attendees; 
  final String? imageUrl;       
  final String? type;          

  Event({
    required this.eventID,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.createdAt,
    this.attendees = const [],
    this.imageUrl,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'eventID': eventID,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'createdAt': createdAt.toIso8601String(),
      'attendees': attendees,
      'imageUrl': imageUrl,
      'type': type,
    };
  }

  factory Event.fromJson(Map<String, dynamic> map) {
    return Event(
      eventID: map['eventID'],
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      location: map['location'],
      createdAt: DateTime.parse(map['createdAt']),
      attendees: map['attendees'] != null
          ? List<String>.from(map['attendees'])
          : [],
      imageUrl: map['imageUrl'],
      type: map['type'],
    );
  }
}
