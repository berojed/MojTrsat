import 'dart:ffi';

class Payment {
  String paymentID;
  String userID;
  Double amount;
  DateTime date;
  DateTime createdAt;

  Payment({required this.paymentID, required this.userID, required this.amount, required this.date, required this.createdAt});

  Map<String,dynamic> toMap()
  {
    return{
      'paymentID':paymentID,
      'userID':userID,
      'amount':amount,
      'date':date,
      'createdAt':createdAt
    };
  }

  factory Payment.fromMap(Map<String,dynamic> map)
  {

    String paymentID=map['paymentID'];
    String userID=map['userID'];
    Double amount=map['amount'];
    DateTime date = DateTime.parse(map['date']);
    DateTime createdAt = DateTime.parse(map['createdAt']);

    return Payment(paymentID:paymentID , userID: userID, amount: amount, date: date, createdAt: createdAt);
    
  }


}