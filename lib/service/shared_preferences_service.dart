import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<String?> getPlayerName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('PlayerName');
    } catch (e) {
      throw Exception('名前の取得中にエラーが発生しました');
    }
  }

  Future<void> savePlayerName(String playerName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('PlayerName', playerName);
    } catch (e) {
      throw Exception('名前の保存中にエラーが発生しました');
    }
  }

  Future<String?> getPlayerID() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('PlayerID');
    } catch (e) {
      throw Exception('PlayerIDの取得中にエラーが発生しました');
    }
  }

  Future<void> savePlayerID(String playerID) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('PlayerID', playerID);
    } catch (e) {
      throw Exception('PlayerIDの保存中にエラーが発生しました');
    }
  }
}
