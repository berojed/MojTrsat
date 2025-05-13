import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/chatmessage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatViewModel extends StateNotifier<List<Chatmessage>> {
  final SupabaseClient _supabase;

  ChatViewModel(this._supabase) : super([]);


  // Method to fetch all conversations
  // This method listens to the 'chat_messages' table and filters messages
  void fetchConversations() {
    final currentUser = _supabase.auth.currentUser?.id;

    if (currentUser == null) {
      print("User not logged in");
      return;
    }

    try {
      _supabase
          .from('chat_messages')
          .stream(primaryKey: ['messageid'])
          .order('createdAt', ascending: true)
          .listen((List<Map<String, dynamic>> messagesData) {
            List<Chatmessage> allmessages = messagesData.map((message) {
              return Chatmessage.fromJson(message);
            }).toList();

            List<Chatmessage> filteredMessages = allmessages
                .where((message) =>
                    message.senderID == currentUser ||
                    message.reciverID == currentUser)
                .toList();

            Map<String, Chatmessage> latestMessages = {};

            for (var message in filteredMessages) {
              final otherUserId = message.senderID == currentUser
                  ? message.reciverID
                  : message.senderID;

              if (!latestMessages.containsKey(otherUserId) ||
                  message.createdAt
                      .isAfter(latestMessages[otherUserId]!.createdAt)) {
                latestMessages[otherUserId] = message;
              }
            }

            state = latestMessages.values.toList();
          });
    } catch (e) {
      print('Error fetching chat messages: $e');
    }
  }

  // Method to fetch individual chat messages
  Future <void> fetchIndividualChatMessages() async {
    final currentUser = _supabase.auth.currentUser?.id;

    if (currentUser == null) {
      print("User not logged in");
      return;
    }

    try {
      await _supabase
          .from('chat_messages')
          .stream(primaryKey: ['messageid'])
          .order('createdAt', ascending: true)
          .listen((List<Map<String, dynamic>> messagesData) {
            List<Chatmessage> allmessages = messagesData.map((message) {
              return Chatmessage.fromJson(message);
            }).toList();

            List<Chatmessage> filteredMessages = allmessages
                .where((message) =>
                    message.senderID == currentUser ||
                    message.reciverID == currentUser)
                .toList();


            state = filteredMessages;
            
          });
    } catch (e) {
      print('Error fetching chat messages: $e');
    }
  }

  // Method to send a message
  // This method inserts a new message into the 'chat_messages' table
  // It takes the receiver's ID and the message content as parameters
  Future<void> sendMessage(String reciverID, String message) async {
    try {
      final currentUser = _supabase.auth.currentUser;

      if (currentUser == null) {
        print('User not logged in');
        return;
      }

      await _supabase.from('chat_messages').insert({
        'senderid': currentUser.id,
        'reciverid': reciverID,
        'message': message,
      });
    } catch (e) {
      print('Error fetching chat messages: $e');
    }
  }

  // Method to start a new chat
  // This method inserts a new chat into the 'chat_messages' table
  Future<void> startNewChat(String reciverID) async {
    try {
      final currentUser = _supabase.auth.currentUser;

      if (currentUser == null) {
        print('User not logged in');
        return;
      }

      await _supabase.from('chat_messages').insert({
        'senderid': currentUser.id,
        'reciverid': reciverID
      });
    } catch (e) {
      print('Error starting new chat: $e');
    }
  }

  Future<void> deleteChat(String reciverID) async {
    try {
      final currentUser = _supabase.auth.currentUser;

      if (currentUser == null) {
        print('User not logged in');
        return;
      }

      await _supabase.from('chat_messages').delete().eq('reciverid', reciverID).eq('senderid', currentUser.id);
    } catch (e) {
      print('Error deleting chat: $e');
    }
  }
}
