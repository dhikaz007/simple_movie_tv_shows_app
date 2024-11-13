part of 'utils.dart';

class LocalStorage {
  static Future<SharedPreferences> getPrefs() async =>
      SharedPreferences.getInstance();

  static Future<void> setfirstLaunchApp() async {
    SharedPreferences prefs = await getPrefs();
    prefs.setBool("firstTime", true);
  }

  static Future<bool> getfirstLaunchApp() async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getBool("firstTime") ?? false;
  }

  static Future<void> setAccessToken({required String token}) async {
    SharedPreferences prefs = await getPrefs();
    prefs.setString("access_token", token);
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getString("access_token");
  }

  static Future<void> setSessionId({required String id}) async {
    SharedPreferences prefs = await getPrefs();
    prefs.setString("session_id", id);
  }

  static Future<String?> getSessionId() async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getString("session_id");
  }

  static Future<void> removeToken() async {
    SharedPreferences prefs = await getPrefs();
    prefs.remove('access_token');
    prefs.remove('session_id');
  }
}
