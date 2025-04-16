import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  late Future<SharedPreferences> pref;

  // constructor
  PreferenceManager() {
    pref = SharedPreferences.getInstance();
  }

  // add preferences
  Future<void> setTheme(bool isDarkMode) async {
    final SharedPreferences prefs = await pref;
    prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<void> setColor(String color) async {
    final SharedPreferences prefs = await pref;
    prefs.setString('color', color);
  }

  Future<void> setFontSize(double fontSize) async {
    final SharedPreferences prefs = await pref;
    prefs.setDouble('fontSize', fontSize);
  }

  // get preferences
  Future<bool> getTheme() async {
    final SharedPreferences prefs = await pref;
    return prefs.getBool('isDarkMode') ?? false;
  }

  Future<String> getColor() async {
    final SharedPreferences prefs = await pref;
    return prefs.getString('color') ?? '0xff000000';
  }

  Future<double> getFontSize() async {
    final SharedPreferences prefs = await pref;
    return prefs.getDouble('fontSize') ?? 16.0;
  }

  // clear preferences

  Future<void> clearPreferences() async {
    final SharedPreferences prefs = await pref;
    prefs.clear();
  }

}
