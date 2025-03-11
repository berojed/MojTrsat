class Reservation {

  String reservationID;
  String userID;
  String type;
  DateTime timeSlot;
  DateTime createdAt;

  Reservation({required this.reservationID,required this.userID, required this.type, required this.timeSlot, required this.createdAt });

  Map<String,dynamic> toMap()
  {
    return{
      'reservationID':reservationID,
      'userID':userID,
      'type':type,
      'timeSlot':timeSlot,
      'createdAt':createdAt
    };
  }

  factory Reservation.fromMap(Map<String,dynamic> map)
  {
    String reservationID = map['reservationID'];
    String userID = map['userID'];
    String type = map['type'];
    DateTime timeSlot = DateTime.parse(map['timeSlot']); 
    DateTime createdAt =DateTime.parse(map ['createdAt']); 

    return Reservation(reservationID:reservationID, userID: userID, type: type,timeSlot: timeSlot, createdAt: createdAt);
  }
}

