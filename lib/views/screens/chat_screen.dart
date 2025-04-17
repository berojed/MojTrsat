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
    ref.read(chatViewModelProvider.notifier).fetchMessages('5aaf3c05-5346-4567-bf85-12cfe19a292f');
  }

  @override
  Widget build(BuildContext context) {
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
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(chatViewModelProvider.notifier).fetchMessages('5aaf3c05-5346-4567-bf85-12cfe19a292f');
  }

  final TextEditingController _controller = TextEditingController();
  final String reciverID =
      '5aaf3c05-5346-4567-bf85-12cfe19a292f'; // Replace with actual receiver ID

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatViewModelProvider);
    final _supabase = ref.watch(supabaseClientProvider);
    final currentUser = _supabase.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final isMe = messages[index].senderID == currentUser?.id;
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
                            messages[index].senderID,
                            style: TextStyle(color: Colors.grey, fontSize: 8),
                          ),
                          Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                          Text(
                            
                            messages[index].message,
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
                        .sendMessage(reciverID, _controller.text);
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
