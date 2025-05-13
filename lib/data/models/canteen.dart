class Canteen {
  String canteenID;
  String canteenName;
  String menu1;
  String menu2;
  String menu3;
  DateTime updatedAt;
  String workingHours_weekday;
  String workingHours_weekend;
  

  Canteen(
      {required this.canteenID,
      required this.canteenName,
      required this.menu1,
      required this.menu2,
      required this.menu3,
      required this.updatedAt,
      required this.workingHours_weekday,
      required this.workingHours_weekend
      });

  Map<String, dynamic> toJson() {
    return {
      'canteenID': canteenID,
      'canteenName': canteenName,
      'menu1':menu1,
      'menu2':menu2,
      'menu3':menu3,
      'updated_at': updatedAt,
      'workingHours_weekday': workingHours_weekday,
      'workingHours_weekend': workingHours_weekend
      
    };
  }

  factory Canteen.fromJson(Map<String, dynamic> map) {
    String canteenID = map['canteenID'] ?? '';
    String canteenName = map['canteenName'] ?? '';
    String menu1 = map['menu1'] ?? '';
    String menu2 = map['menu2'] ?? '';
    String menu3 = map['menu3'] ?? '';
    DateTime updated_at = DateTime.parse(map['updated_at'] ?? '') ;
    String workingHours_weekday = map['workinghours_weekday'] ?? '';
    String workingHours_weekend = map['workinghours_weekend'] ?? '';
    

    return Canteen(
        canteenID: canteenID,
        canteenName: canteenName,
        menu1: menu1,
        menu2: menu2,
        menu3: menu3,
        updatedAt: updated_at,
        workingHours_weekday: workingHours_weekday,
        workingHours_weekend: workingHours_weekend
        );
  }
}
