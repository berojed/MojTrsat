import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatCard extends StatelessWidget {
  final String name;
  final String lastmessage;
  final DateTime lastmessageTime;

  const ChatCard(
      {required this.name,
      required this.lastmessage,
      required this.lastmessageTime});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/individual_chat');
      },
      child: 
        Card(
          color: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lastmessage,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lastmessageTime.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        )
      ,
    );
  }
}
