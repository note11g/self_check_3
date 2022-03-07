import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  static const _ab = 'npnp2';

  static Future<bool> savePW(String pw) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_ab, pw);
      return true;
    } catch (e) {
      print("[SavePW Error] ${e.toString()}");
      return false;
    }
  }

  static Future<String?> getPw() async {
    final prefs = await SharedPreferences.getInstance();
    final String? pw = prefs.getString(_ab);
    return pw;
  }

  static Future<bool> deletePw() async {
    final prefs = await SharedPreferences.getInstance();
    final bool succeed = await prefs.remove(_ab);
    return succeed;
  }
}