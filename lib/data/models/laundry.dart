class Laundry {
  String laundryID;
  int machineID;
  String reservationTime;
  int availability;
  DateTime createdAt;

  Laundry(
      {required this.laundryID,
      required this.machineID,
      required this.reservationTime,
      required this.availability,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'laundryID': laundryID,
      'machineID': machineID,
      'reservationTime': reservationTime,
      'availability': availability,
      'createdAt': createdAt
    };
  }

  factory Laundry.fromMap(Map<String, dynamic> map) {
    String laundryID = map['laundryID'];
    int machineID = map['machineID'];
    String reservationTime = map['reservationTime'];
    int availability = map['availability'];
    DateTime createdAt = DateTime.parse(map['createdAt']);

    return Laundry(
        laundryID: laundryID,
        machineID: machineID,
        reservationTime: reservationTime,
        availability: availability,
        createdAt: createdAt);
  }
}
