class GymMembership {
  String membershipID;
  String userID;
  String? membershipType;
  int membershipLength;
  int membershipDaysLeft;
  List<String> membershipHistory = [];
  DateTime createdAt;

  GymMembership({required this.membershipID, required this.userID, required this.membershipType, required this.membershipLength, required this.membershipDaysLeft, required this.membershipHistory, required this.createdAt});

  Map<String,dynamic> toJson()
  {
    return{
      'membershipID':membershipID,
      'userID':userID,
      'membershipType':membershipType,
      'membershipLength':membershipLength,
      'membershipDaysLeft':membershipDaysLeft,
      'membershipHistory':membershipHistory,
      'createdAt':createdAt.toIso8601String()
    };
  }

  factory GymMembership.fromJson(Map<String,dynamic> json)
  {
    return GymMembership(
      membershipID:json["membershipID"] ?? "", 
      userID: json["userID"] ?? "",
      membershipType: json["membershipType"] ?? "", 
      membershipLength: json["membershipLength"] ?? 0,
      membershipDaysLeft: json["membershipDaysLeft"] ?? 0,
      membershipHistory: (json["membershipHistory"] != null) ? List<String>.from(json["membershipHistory"]) : [],
      createdAt: (json["createdAt"] != null)
            ? (json["createdAt"] is String
                ? DateTime.parse(json['createdAt'])
                : json['createdAt'])
            : DateTime.now(),
    );
    
  }


}