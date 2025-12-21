import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _lastTabKey = 'last_tab_index';
  static const _usernameKey = 'saved_username';

  Future<int> loadLastTab() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_lastTabKey) ?? 1;
  }

  Future<void> saveLastTab(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastTabKey, index);
  }

  Future<String?> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }
}
