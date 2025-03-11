
import 'dart:ffi';

class Canteen {
  String canteenID;
  Double dailySpendingLimit;
  Double currentSpending;
  String workingHours;
  DateTime createdAt;

  Canteen({required this.canteenID, required this.dailySpendingLimit, required this.currentSpending, required this.workingHours, required this.createdAt});

  Map<String,dynamic> toMap()
  {
    return{
      'canteenID':canteenID,
      'dailySpendingLimit':dailySpendingLimit,
      'currentSpending':currentSpending,
      'workingHours':workingHours,
      'createdAt':createdAt
    };
  }

  factory Canteen.fromMap(Map<String,dynamic> map)
  {

    String canteenID=map['canteenID'];
    Double dailySpendingLimit=map['dailySpendingLimit'];
    Double currentSpending=map['currentSpending'];
    String workingHours = map['workingHours'];
    DateTime createdAt = DateTime.parse(map['createdAt']);

    return Canteen(canteenID: canteenID, dailySpendingLimit: dailySpendingLimit, currentSpending: currentSpending, workingHours: workingHours, createdAt: createdAt);
    
  }


}