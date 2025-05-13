import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final SharedPrefService _singletonInstance =
      SharedPrefService._internal();

  factory SharedPrefService() {
    return _singletonInstance;
  }

  SharedPrefService._internal();

  SharedPreferences? prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? getStringValue(String key) {
    return prefs?.getString(key);
  }

  dynamic getBoolValue(String key) {
    return prefs?.getBool(key);
  }

  Future<bool?> deleteValue(String key) async {
    return await prefs?.remove(key);
  }

  Future<void> setStringValue(String key, dynamic value) async {
    await prefs?.setString(key, value);
  }

  Future<void> setBoolValue(String key, bool value) async {
    await prefs?.setBool(key, value);
  }

  Future<void> clearAll() async {
    await prefs?.clear();
  }
}
