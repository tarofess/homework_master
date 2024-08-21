import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('Username');
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Username', username);
  }
}
