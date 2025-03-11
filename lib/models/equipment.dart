
class Equipment {
  String equipmentID;
  String name;
  String availability;
  String location;
  DateTime createdAt;

  Equipment({required this.equipmentID, required this.name, required this.availability, required this.location, required this.createdAt});

  Map<String,dynamic> toMap()
  {
    return{
      'equipmentID':equipmentID,
      'name':name,
      'availability':availability,
      'location':location,
      'createdAt':createdAt
    };
  }

  factory Equipment.fromMap(Map<String,dynamic> map)
  {

    String equipmentID=map['equipmentID'];
    String name=map['name'];
    String availability=map['availability'];
    String location = map['location'];
    DateTime createdAt = DateTime.parse(map['createdAt']);

    return Equipment(equipmentID: equipmentID, name: name, availability: availability, location: location, createdAt: createdAt);
    
  }


}