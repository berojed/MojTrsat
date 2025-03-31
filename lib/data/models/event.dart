
class Event {
  String eventID;
  String title;
  String description;
  DateTime date;
  String location;
  DateTime createdAt;

  Event({required this.eventID, required this.title,  required this.description, required this.date, required this.location, required this.createdAt});

  Map<String,dynamic> toMap()
  {
    return{
      'eventID':eventID,
      'title':title,
      'description':description,
      'date': date,
      'location':location,
      'createdAt':createdAt
    };
  }

  factory Event.fromMap(Map<String,dynamic> map)
  {

    String eventID=map['eventID'];
    String title=map['title'];
    String description=map['description'];
    DateTime date = DateTime.parse('date');
    String location = map['location'];
    DateTime createdAt = DateTime.parse(map['createdAt']);

    return Event(eventID: eventID, title: title, description: description, date: date, location: location, createdAt: createdAt);
    
  }


}