
class Student {
  String id;
  String name;
  String surname;
  String email;
  int phoneNumber;
  String faculty;
  int jmbag;
  double amountSpent;
  double amountLeft;
  double amountDaily;

  Student(
      {required this.amountSpent,
      required this.amountLeft,
      required this.amountDaily,
      required this.id,
      required this.name,
      required this.surname,
      required this.email,
      required this.phoneNumber,
      required this.faculty,
      required this.jmbag});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'phone_number': phoneNumber,
      'faculty': faculty,
      'jmbag': jmbag,
      'amount_spent': amountSpent,
      'amount_left': amountLeft,
      'amount_daily': amountDaily
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {

    return Student(
        id: json["userid"].toString(),
        name: json["name"],
        surname: json["surname"],
        email: json["email"] ?? '',
        phoneNumber: json["phone_number"],
        faculty: json["faculty"],
        jmbag: json["jmbag"],
        amountSpent: (json["amount_spent_today"] as num).toDouble(),
        amountLeft: (json["monthly_amount_left"] as num).toDouble(),
        amountDaily: (json["daily_support_amount"] as num).toDouble(),
        );
  }
}
