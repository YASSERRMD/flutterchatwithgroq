import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<void> saveAPIKey(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_key', apiKey);
  }

  Future<String?> getAPIKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('api_key');
  }
}
