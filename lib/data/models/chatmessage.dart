
class Chatmessage {
  String messageID;
  String userID;
  String content;
  DateTime timestamp;
  DateTime createdAt;

  Chatmessage({required this.messageID, required this.userID, required this.content, required this.timestamp, required this.createdAt});

  Map<String,dynamic> toMap()
  {
    return{
      'messageID':messageID,
      'userID':userID,
      'acontent':content,
      'timestamp':timestamp,
      'createdAt':createdAt
    };
  }

  factory Chatmessage.fromMap(Map<String,dynamic> map)
  {

    String messageID=map['messageID'];
    String userID=map['userID'];
    String content=map['content'];
    DateTime timestamp = DateTime.parse(map['timestamp']);
    DateTime createdAt = DateTime.parse(map['createdAt']);

    return Chatmessage(messageID:messageID , userID: userID, content: content, timestamp: timestamp, createdAt: createdAt);
    
  }


}