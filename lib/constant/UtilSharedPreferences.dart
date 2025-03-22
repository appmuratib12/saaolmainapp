import 'package:shared_preferences/shared_preferences.dart';

class UtilSharedPreferences {
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '';
  }

  static Future setMessage(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('LogoutMessage', value);
  }

  static Future setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', value);
  }
}
