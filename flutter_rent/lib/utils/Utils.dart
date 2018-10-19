import 'dart:math';

import 'package:flutter/services.dart';

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

  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  static copyToClipboard(final String text) {
    if (text == null) return;
    Clipboard.setData(new ClipboardData(text: text));
  }

  static const _RollupSize_Units = ["GB", "MB", "KB", "B"];

  static String getRollupSize(int size) {
    int idx = 3;
    int r1 = 0;
    String result = "";
    while (idx >= 0) {
      int s1 = size % 1024;
      size = size >> 10;
      if (size == 0 || idx == 0) {
        r1 = (r1 * 100) ~/ 1024;
        if (r1 > 0) {
          if (r1 >= 10)
            result = "$s1.$r1${_RollupSize_Units[idx]}";
          else
            result = "$s1.0$r1${_RollupSize_Units[idx]}";
        } else
          result = s1.toString() + _RollupSize_Units[idx];
        break;
      }
      r1 = s1;
      idx--;
    }
    return result;
  }
}

