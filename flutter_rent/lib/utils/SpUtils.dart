import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static SharedPreferences _prefs;

  static SPUtil _instance;

  static Future<SPUtil> getInstance() async {
    if (_instance == null) {
      _instance = new SPUtil._();
      _instance._init();
    }
    return _instance;
  }

  SPUtil._();

  _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  getSP() {
    return _prefs;
  }
}
