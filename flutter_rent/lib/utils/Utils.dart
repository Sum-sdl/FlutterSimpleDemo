import 'dart:math';

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
