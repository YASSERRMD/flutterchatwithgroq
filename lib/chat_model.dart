import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatMessage {
  final String role;
  final String content;

  ChatMessage({required this.role, required this.content});

  // Convert a ChatMessage into a Map for insertion into the database
  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }

  // Convert a Map into a ChatMessage object
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      role: json['role'],
      content: json['content'],
    );
  }
}

class ChatModel extends ChangeNotifier {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  Future<void> sendMessage(String content) async {
    final userMessage = ChatMessage(role: 'user', content: content);
    _messages.insert(0, userMessage);
    notifyListeners();

    final assistantResponse = await _callGroqAPI(content);
    if (assistantResponse != null) {
      _messages.insert(0, assistantResponse);
      notifyListeners();
    }
  }

  Future<ChatMessage?> _callGroqAPI(String userInput) async {
    final apiKey = await _getAPIKeyFromSettings(); // Get from local settings
    final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'messages': [
          {'role': 'user', 'content': userInput}
        ],
        'model': 'llama3-70b-8192',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final assistantContent = data['choices'][0]['message']['content'];
      return ChatMessage(role: 'assistant', content: assistantContent);
    }
    return null;
  }

  Future<String> _getAPIKeyFromSettings() async {
    // Implement the logic to retrieve the API key from local storage
    return 'your_api_key'; // Placeholder
  }
}
