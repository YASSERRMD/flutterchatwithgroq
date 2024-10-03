# FutterChatWithGroq

FutterChatWithGroq is a chat application built using **Flutter** and integrates **Groq** with **Meta LLaMA3-70B-8192** to offer a fast and efficient AI-powered chat experience. The app uses a modern layout with a dark orange theme and includes functionality to store chat history locally with SQLite.

## Features

- Modern chat interface with Flutter
- AI-powered chat using Groq and Meta LLaMA3-70B-8192
- Chat history stored locally using SQLite
- Send messages via the Enter key or a dedicated Send button

## Installation Instructions

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/FutterChatWithGroq.git
   cd FutterChatWithGroq
   ```

2. **Install dependencies:**

   Run the following command to install all necessary dependencies:

   ```bash
   flutter pub get
   ```

3. **Setup API Key:**

   The function `_getAPIKeyFromSettings()` is a placeholder and needs to be updated to retrieve the Groq API key from local storage or simply return it for testing.

   ```dart
   Future<String> _getAPIKeyFromSettings() async {
     // Implement the logic to retrieve the API key from local storage
     return 'your_api_key'; // Placeholder
   }
   ```

   **Note:** It is left for the user to implement the logic for storing and retrieving the API key. Make sure to update this part before running the app.

4. **Run the app:**

   After setting up the API key, you can run the app using:

   ```bash
   flutter run
   ```

---

Enjoy using **FutterChatWithGroq** for your chat applications! Let us know your feedback and contributions are always welcome!
