import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yshz/ui/product/sort_list.dart';

class RouterHelper {
  /// 分类列表
  static sort2List(
    BuildContext context,
    String title,
    String sortId,
    bool hasChild,
  ) {
    if (null == sortId) {
      return;
    }
    //手势滑动进入
    Navigator.of(context).push(new CupertinoPageRoute(builder: (c) {
      return new SortList(
        title: title,
        sortId: sortId,
        hasChild: hasChild,
      );
    }));
  }

  ///房源列表
  static sort2HouseList(BuildContext context) {
    Navigator.of(context).push(new CupertinoPageRoute(builder: (c) {
      return new SortList(
        title: "",
        sortId: "",
      );
    }));
  }
}
