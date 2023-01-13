import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getToken() async {
    final SharedPreferences prefs = await _prefs;
    return  prefs.getString("token");
  }

}
