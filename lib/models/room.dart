
class Room {
  String roomID;
  String name;
  String capacity;
  String availability;
  DateTime createdAt;

  Room({required this.roomID, required this.name, required this.capacity, required this.availability, required this.createdAt});

  Map<String,dynamic> toMap()
  {
    return{
      'roomID':roomID,
      'name':name,
      'capacity':capacity,
      'availability':availability,
      'createdAt':createdAt
    };
  }

  factory Room.fromMap(Map<String,dynamic> map)
  {

    String roomID=map['roomID'];
    String name=map['name'];
    String capacity = map['capacity'];
    String availability=map['availability'];
    DateTime createdAt = DateTime.parse(map['createdAt']);

    return Room(roomID: roomID, name: name, capacity: capacity, availability: availability, createdAt: createdAt);
    
  }


}