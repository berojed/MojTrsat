import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/viewmodels/providers.dart';
import 'package:mojtrsat/views/widgets/chat_card.dart';

class WholeChatScreen extends ConsumerStatefulWidget {
  const WholeChatScreen({super.key});
  

  @override
  _WholeChatScreenState createState() => _WholeChatScreenState();
}

class _WholeChatScreenState extends ConsumerState<WholeChatScreen> {
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    ref.read(chatViewModelProvider.notifier).fetchConversations();
    final messages = ref.watch(chatViewModelProvider);
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Poruke', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF121212),
      ),
      backgroundColor: Color(0xFF121212),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: messages.isEmpty
                  ? Text(
                      "No messages available",
                      style: TextStyle(color: Colors.white),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(2),
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.all(5),
                              child: ChatCard(
                                  name: messages[index].reciverID,
                                  lastmessage: messages[index].message,
                                  lastmessageTime: messages[index].createdAt));
                        },
                      ),
                    )),
        ],
      ),
    );
  }
}

class ChatScreen extends ConsumerStatefulWidget {

  const ChatScreen({super.key,});
  

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(chatViewModelProvider.notifier).fetchIndividualChatMessages();
  }

  final TextEditingController _controller = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    
    final individualChatMessages = ref.watch(chatViewModelProvider);
    final supabase = ref.watch(supabaseClientProvider);
    final currentUser = supabase.auth.currentUser;


    
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: individualChatMessages.length,
              itemBuilder: (context, index) {
                final isMe = individualChatMessages[index].senderID == currentUser?.id;
                return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            individualChatMessages[index].senderID,
                            style: TextStyle(color: Colors.grey, fontSize: 8),
                          ),
                          Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                          Text(
                            
                            individualChatMessages[index].message,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black,

                            ),
                          )
                        ]),
                      ),
                    ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    ref
                        .read(chatViewModelProvider.notifier)
                        .sendMessage('reciverID', _controller.text);
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
