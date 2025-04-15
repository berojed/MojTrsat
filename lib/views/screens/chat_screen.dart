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
    ref.read(chatViewModelProvider.notifier).fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Poruke', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF121212),
        
      ),
      backgroundColor:Color(0xFF121212),
      body: 
      Column(
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
    ref.read(chatViewModelProvider.notifier).fetchMessages();
  }

  final TextEditingController _controller = TextEditingController();
  final String reciverID =
      '0a8009da-becc-47c1-8ce2-0e9f2e82f6b5'; // Replace with actual receiver ID

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatViewModelProvider);

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
                return ListTile(
                  title: Text(messages[index].message.toString()),
                );
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
