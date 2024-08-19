import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopViewModel {
  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('Username');
    return username == null ? true : false;
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Username', username);
  }
}

final topViewModelProvider = Provider((ref) => TopViewModel());
