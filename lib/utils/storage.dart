import 'package:shared_preferences/shared_preferences.dart';

enum StorageKeys {
  uid,
  code,
}

class Storage {
  SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String getUID() {
    return _prefs.getString(StorageKeys.uid.toString());
  }

  Future<void> setUID(uid) {
    return _prefs.setString(StorageKeys.uid.toString(), uid);
  }

  Future<void> clearUID() {
    return _prefs.remove(StorageKeys.uid.toString());
  }

  String getGameCode() {
    return _prefs.getString(StorageKeys.code.toString());
  }

  Future<void> setGameCode(code) {
    return _prefs.setString(StorageKeys.code.toString(), code);
  }

  Future<void> clearGameCode() {
    return _prefs.remove(StorageKeys.code.toString());
  }
}
