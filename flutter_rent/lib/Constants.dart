import 'dart:ui';

import 'package:flutter/cupertino.dart';

/// const和final修饰的变量，类型可以省略
/// 类级别常量使用static const
/// 任何一个变量都可以是常量，用const修饰

class ResImages {
  ResImages._();

  static const image_home_op1 = "images/ic_home_grid_1.png";
  static const image_home_op2 = "images/ic_home_grid_2.png";
  static const image_home_op3 = "images/ic_home_grid_3.png";
  static const image_home_op4 = "images/ic_home_grid_4.png";
  static const image_home_op5 = "images/ic_home_grid_5.png";
  static const image_home_op6 = "images/ic_home_grid_6.png";
  static const image_home_op7 = "images/ic_home_grid_7.png";
  static const image_home_op8 = "images/ic_home_grid_8.png";
  static const image_home_search = "images/ic_home_search.png";
  static const image_error = "images/img_bg_shelves.png";
}

class ResColors {
  ResColors._();

  static const Color color_text_333333 = Color(0xFF333333);
  static const Color color_text_666666 = Color(0xFF666666);
  static const Color color_text_999999 = Color(0xFF999999);
  static const Color color_line = Color(0xFFe5e5e5);
}

class ResDimens {

  static const EdgeInsets padding_left = EdgeInsets.only(
      left: dimen_pub_padding);
  static const EdgeInsets padding = EdgeInsets.all(
      dimen_pub_padding);

  static const double dimen_pub_padding = 14.0;
  static const double dimen_pub_status_bar_height = 24.0;

  ResDimens._();
}