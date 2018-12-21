//管理一组底部按钮的单选状态组件
import 'package:flutter/material.dart';

typedef ItemCallBack = void Function(ChooseItem item);

class ChooseItem {
  ChooseItem(
    this.title, {
    @required this.index,
    this.choose = false,
    this.imageResNor,
    this.icon,
    this.imageResActive,
    this.fontSize = 10.0,
    this.imageSize = 22.0,
    this.textColorNor = Colors.grey,
    this.textColorActive = Colors.black,
    this.callback,
  });

  final int index;
  final String title;
  final double fontSize;
  final Color textColorNor;
  final Color textColorActive;
  final IconData icon;
  final double imageSize;
  final String imageResNor;
  final String imageResActive;
  final ItemCallBack callback;
  bool choose;
}

class BottomNavBarWidget extends StatefulWidget {
  final List<ChooseItem> items;
  final ChooseItem defaultChooseItem; //默认选项

  const BottomNavBarWidget({@required this.items, this.defaultChooseItem});

  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  ChooseItem curItem; //默认选项

  @override
  initState() {
    curItem = widget.defaultChooseItem;
    super.initState();
  }

  //bar点击的，局部刷新
  _itemBarClick(ChooseItem item) {
    if (curItem != item) {
      curItem.choose = false;
      item.choose = true;
      setState(() {
        curItem = item;
      });
      item.callback(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.map((item) {
          return _BottomBarItem(
            item: item,
            itemBarClick: _itemBarClick,
          );
        }).toList());
  }
}

class _BottomBarItem extends StatelessWidget {
  final ChooseItem item;
  final ItemCallBack itemBarClick;

  const _BottomBarItem({Key key, this.item, this.itemBarClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) => barItem();

  Widget barItem() {
    return InkResponse(
      //没类型需要动态，定义typedef 回调，类型固定,
      onTap: () {
        itemBarClick(item);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildImage(item),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                item.title,
                style: TextStyle(
                    fontSize: item.fontSize,
                    color:
                        item.choose ? item.textColorActive : item.textColorNor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(ChooseItem item) {
    if (item.imageResNor != null && item.imageResNor.length != 0) {
      return SizedBox(
        width: item.imageSize,
        height: item.imageSize,
        child:
            Image.asset(item.choose ? item.imageResActive : item.imageResNor),
      );
    }
    if (item.icon != null) {
      return Icon(
        item.icon,
        color: item.choose ? item.textColorActive : item.textColorNor,
      );
    }
    return Icon(Icons.home);
  }
}
