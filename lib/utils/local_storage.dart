part of 'utils.dart';

class LocalStorage {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static FlutterSecureStorage _flutterSecureStorage() =>
      FlutterSecureStorage(aOptions: _getAndroidOptions());

  static Future<void> setfirstLaunchApp() async {
    FlutterSecureStorage prefs = _flutterSecureStorage();
    await prefs.write(key: "firstTime", value: 'true');
  }

  static Future<String?> getfirstLaunchApp() async {
    FlutterSecureStorage prefs = _flutterSecureStorage();
    return await prefs.read(key: "firstTime");
  }

  static Future<void> setAccessToken({required String token}) async {
    FlutterSecureStorage prefs = _flutterSecureStorage();
    await prefs.write(key: "access_token", value: token);
  }

  static Future<void> setRegion({required String region}) async {
    FlutterSecureStorage prefs = _flutterSecureStorage();
    await prefs.write(key: "region", value: region);
  }

  static Future<String?> getRegion() async {
    FlutterSecureStorage prefs = _flutterSecureStorage();
    return await prefs.read(key: "region");
  }

  static Future<String?> getAccessToken() async {
    FlutterSecureStorage prefs = _flutterSecureStorage();
    return await prefs.read(key: "access_token");
  }

  static Future<void> setSessionId({required String id}) async {
    FlutterSecureStorage prefs = _flutterSecureStorage();
    await prefs.write(key: "session_id", value: id);
  }

  static Future<String?> getSessionId() async {
    FlutterSecureStorage prefs = _flutterSecureStorage();
    return await prefs.read(key: "session_id");
  }

  static Future<void> removeToken() async {
    FlutterSecureStorage prefs = _flutterSecureStorage();
    prefs.delete(key: 'access_token');
    prefs.delete(key: 'session_id');
  }
}
