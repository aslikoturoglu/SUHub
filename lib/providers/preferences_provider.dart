import 'package:flutter/foundation.dart';

import '../services/preferences_service.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesProvider(this._service);

  final PreferencesService _service;

  int lastTabIndex = 0;
  String? savedUsername;
  bool loaded = false;

  Future<void> load() async {
    lastTabIndex = await _service.loadLastTab();
    savedUsername = await _service.loadUsername();
    loaded = true;
    notifyListeners();
  }

  Future<void> setLastTab(int index) async {
    lastTabIndex = index;
    notifyListeners();
    await _service.saveLastTab(index);
  }

  Future<void> setUsername(String username) async {
    savedUsername = username;
    notifyListeners();
    await _service.saveUsername(username);
  }
}
