class Event {
  String eventID;
  String title;
  String description;
  DateTime date;
  String location;
  DateTime createdAt;

  Event({
    required this.eventID,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventID': eventID,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      eventID: map['eventID'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      date: DateTime.parse(map['date']),
      location: map['location'] as String,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
