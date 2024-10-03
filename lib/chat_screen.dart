import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Add FocusNode to manage input focus

  @override
  Widget build(BuildContext context) {
    final chatModel = Provider.of<ChatModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Groq Assistant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: chatModel.messages.length,
              itemBuilder: (context, index) {
                final message = chatModel.messages[index];
                return Align(
                  alignment: message.role == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: message.role == 'user'
                          ? Colors.orange
                          : Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message.content,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
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
                    focusNode: _focusNode,  // Set the focus node here
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white24,
                    ),
                    textInputAction: TextInputAction.send,  // Show send button in keyboard
                    onSubmitted: (value) async {
                      if (value.trim().isNotEmpty) {
                        await chatModel.sendMessage(value.trim());
                        _controller.clear();  // Clear input after sending
                        _focusNode.requestFocus();  // Return focus to the text input
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    String content = _controller.text.trim();
                    if (content.isNotEmpty) {
                      await chatModel.sendMessage(content);
                      _controller.clear();  // Clear input after sending
                      _focusNode.requestFocus();  // Return focus to the text input
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
