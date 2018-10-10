import 'package:flutter/material.dart';
import 'package:flutter_rent/Constants.dart';

class CommonDivider {
  static Widget buildDividerLeftRight() {
    return new Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: new Divider(height: 1.0),
    );
  }

  //TODO 思考const代码构造函数中的作用和意义
  static const Widget buildDividerLeft = const Padding(
    padding: const EdgeInsets.only(left: ResDimens.dimen_pub_padding),
    child: const Divider(
      height: 2.0,
      color: Colors.red,
    ),
  );

  CommonDivider._();
}
