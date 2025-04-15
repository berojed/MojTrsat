class Chatmessage {
  String messageID;
  String senderID;
  String reciverID;
  String message;
  DateTime createdAt;

  Chatmessage({required this.messageID, required this.senderID, required this.reciverID, required this.message, required this.createdAt});

  Map<String,dynamic> toJson()
  {
    return{
      'messageid':messageID,
      'senderid':senderID,
      'reciverid':reciverID,
      'message':message,
      'createdAt':createdAt
    };
  }

  factory Chatmessage.fromJson(Map<String,dynamic> json)
  {

    return Chatmessage(
    messageID:json["messageid"], 
    senderID: json["senderid"],
    reciverID: json["reciverid"], 
    message: json["message"],
    createdAt: json["createdAt"] is String
          ? DateTime.parse(json['createdAt'])
          : json['createdAt'],
    );
    
  }


}