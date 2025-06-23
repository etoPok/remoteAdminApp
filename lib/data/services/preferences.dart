import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider extends ChangeNotifier {
  bool notificationsEnabled = true;
  bool confirmBeforeDelete = true;
  bool darkMode = true;
  Duration autoResponseDelay = Duration(minutes: 15);

  PreferencesProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    confirmBeforeDelete = prefs.getBool('confirmBeforeDelete') ?? true;
    darkMode = prefs.getBool('darkMode') ?? true;
    autoResponseDelay = Duration(
      minutes: prefs.getInt('autoResponseDelay') ?? 15,
    );
    notifyListeners();
  }

  Future<void> setNotificationsEnabled(bool value) async {
    notificationsEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);
    notifyListeners();
  }

  Future<void> setConfirmBeforeDelete(bool value) async {
    confirmBeforeDelete = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('confirmBeforeDelete', value);
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    darkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    notifyListeners();
  }

  Future<void> setAutoResponseDelay(Duration duration) async {
    autoResponseDelay = duration;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('autoResponseDelay', duration.inMinutes);
    notifyListeners();
  }
}