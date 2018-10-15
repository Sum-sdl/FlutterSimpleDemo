import 'package:flutter/material.dart';
import 'package:flutter_rent/Constants.dart';

class CommonDivider {

  //2者功能一样
  static Widget buildDividerLeftRight() {
    return new Padding(
      padding: const EdgeInsets.only(left: ResDimens.dimen_pub_padding,
          right: ResDimens.dimen_pub_padding),
      child: new Divider(height: 2.0),
    );
  }

  /// 思考const代码构造函数中的作用和意义
  /// const 定制常量组件，使得组件可以变成一个常量使用
  static const Widget buildDividerLeft = const Padding(
    padding: const EdgeInsets.only(left: ResDimens.dimen_pub_padding),
    child: const Divider(
      height: 1.0,
    ),
  );
  static const Widget buildDivider = const Divider(
    height: 1.0,
  );

  CommonDivider._();
}

