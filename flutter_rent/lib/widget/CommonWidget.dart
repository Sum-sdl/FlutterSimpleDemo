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
