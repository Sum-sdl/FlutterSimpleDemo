import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class Utils {
  static double getProgress(int value, int min, int max) {
    if (min == max) {
      return 1;
    }
    return (value - min) / (max - min);
  }

  static double progressPercent(int value, int target) {
    double progress = getProgress(value, 0, target);
    double curProgress = max(progress, 0);
    return min(curProgress, 1);
  }
}



class SPUtil {
  static SharedPreferences _prefs;

  static SPUtil _instance;

  static Future<SPUtil> getInstance() async {
    if (_instance == null) {
      await synchronized(_lock, () async {
        if (_instance == null) {
          _instance = new SPUtil._();
          await _instance._init();
        }
      });
    }
    return _instance;
  }

  SPUtil._();

  static Object _lock = new Object();

  _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  getSP() {
    return _prefs;
  }

}
