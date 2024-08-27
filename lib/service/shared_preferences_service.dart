import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<String?> getPlayerName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('PlayerName');
  }

  Future<void> savePlayerName(String playerName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('PlayerName', playerName);
  }

  Future<String?> getPlayerID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('PlayerID');
  }

  Future<void> savePlayerID(String playerID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('PlayerID', playerID);
  }
}
