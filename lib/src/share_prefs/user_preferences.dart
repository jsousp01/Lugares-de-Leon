import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static final UserPreferences _instancia = UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();
  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //Lista de fichas almacenadas en memoria
  setStringList(String key, List<String> value) {
    _prefs.setStringList(key, value);
  }
 
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key) ?? [];
  }

}