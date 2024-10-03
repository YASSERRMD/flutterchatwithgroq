import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add Provider package
import 'chat_model.dart'; // Assuming this is your ChatModel file
import 'chat_screen.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatModel()), // Add your provider here
      ],
      child: MaterialApp(
        title: 'Groq Chat App',
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
            primary: Colors.deepOrange,
            secondary: Colors.orangeAccent,
          ),
          brightness: Brightness.dark, // Ensure this matches with ColorScheme
          scaffoldBackgroundColor: Colors.black87,
          appBarTheme: const AppBarTheme(color: Colors.deepOrange),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.orangeAccent,
          ),
        ),
        home: ChatScreen(),
      ),
    );
  }
}
