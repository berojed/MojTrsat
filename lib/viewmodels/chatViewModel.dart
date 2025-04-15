import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/chatmessage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatViewModel extends StateNotifier<List<Chatmessage>> {
  final SupabaseClient _supabase;

  ChatViewModel(this._supabase) : super([]) {
    fetchMessages();
  }

  void fetchMessages() {
    _supabase
        .from('chat_messages')       
        .stream(primaryKey: ['messageid'])
        .order('createdAt', ascending: true)
        .listen((List<Map<String, dynamic>> messages) {
          state =
              messages.map((message) => Chatmessage.fromJson(message)).toList();
        });
  }

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
}
