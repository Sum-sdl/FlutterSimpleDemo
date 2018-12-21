import 'dart:ui';

import 'package:flutter/material.dart';

class ResImages {
  ResImages._();

  static const home_icon_house = "images/home_icon_house.png";
  static const home_tab_home_h = "images/home_tab_home_h.png";
  static const home_tab_home_n = "images/home_tab_home_n.png";
  static const home_tab_mine_h = "images/home_tab_mine_h.png";
  static const home_tab_mine_n = "images/home_tab_mine_n.png";
  static const home_tab_shop_car_h = "images/home_tab_shopcat_h.png";
  static const home_tab_shop_car_n = "images/home_tab_shopcat_n.png";
}

class ResColors {
  ResColors._();

  static const Color colorPrimary = Color(0xFFEA6A2C);
  static const Color colorBg = Color(0xFFF4F4F4);
  static const Color color_text_333333 = Color(0xFF333333);
  static const Color color_text_666666 = Color(0xFF666666);
  static const Color color_text_999999 = Color(0xFF999999);
  static const Color color_text_404040 = Color(0xFF404040);
  static const Color color_text_EEEEEE = Color(0xFFeeeeee);
  static const Color color_line = Color(0xFFe5e5e5);
}

class ResDimens {
  static const EdgeInsets padding_left =
      EdgeInsets.only(left: dimen_pub_padding);

  static const EdgeInsets padding = EdgeInsets.all(dimen_pub_padding);

  static const double dimen_pub_padding = 14.0;

  //22.0
  static const double dimen_pub_status_bar_height = 0.0;

  // 系统高度
  static double statusBarHeight(BuildContext context) {
    EdgeInsets padding = MediaQuery.of(context).padding;
    return padding.top;
  }

  ResDimens._();
}
