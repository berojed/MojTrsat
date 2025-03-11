
class Notification {
  String notificationID;
  String userID;
  String content;
  DateTime timestamp;
  DateTime createdAt;

  Notification({required this.notificationID, required this.userID, required this.content, required this.timestamp, required this.createdAt});

  Map<String,dynamic> toMap()
  {
    return{
      'notificationID':notificationID,
      'userID':userID,
      'acontent':content,
      'timestamp':timestamp,
      'createdAt':createdAt
    };
  }

  factory Notification.fromMap(Map<String,dynamic> map)
  {

    String notificationID=map['notificationID'];
    String userID=map['userID'];
    String content=map['content'];
    DateTime timestamp = DateTime.parse(map['timestamp']);
    DateTime createdAt = DateTime.parse(map['createdAt']);

    return Notification(notificationID:notificationID , userID: userID, content: content, timestamp: timestamp, createdAt: createdAt);
    
  }


}