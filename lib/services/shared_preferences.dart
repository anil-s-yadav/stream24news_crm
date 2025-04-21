import 'package:shared_preferences/shared_preferences.dart';

class LocalStoragePref {
  static LocalStoragePref? instance = LocalStoragePref._();
  SharedPreferences? _prefs;

  LocalStoragePref._();

  Future<void> initPrefBox() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool getLoginBool() => _prefs?.getBool("isLoggedIn") ?? false;

  Future<void> setLoginBool(bool value) async {
    await _prefs?.setBool("isLoggedIn", value);
  }
}
