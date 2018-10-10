import 'package:flutter/material.dart';
import 'package:flutter_rent/Constants.dart';
import 'package:flutter_rent/widget/HouseInfoWidget.dart';

class HomeView extends StatelessWidget {
  HomeView() {
    print("HomeView new");
  }

  @override
  Widget build(BuildContext context) {
    print("HomeView build");
    return _HomePage();
  }
}

class _HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class OpItemData {
  final String name;
  final String localImage;

  OpItemData(this.name, this.localImage);
}

class _HomePageState extends State<_HomePage> {
  List<OpItemData> opItem;

  @override
  void initState() {
    super.initState();
    opItem = new List();
    opItem.add(OpItemData("整租", ResImages.image_home_op1));
    opItem.add(OpItemData("合租", ResImages.image_home_op2));
    opItem.add(OpItemData("公寓", ResImages.image_home_op3));
    opItem.add(OpItemData("月付房源", ResImages.image_home_op4));
    opItem.add(OpItemData("地图找房", ResImages.image_home_op5));
    opItem.add(OpItemData("通勤找房", ResImages.image_home_op6));
    opItem.add(OpItemData("语言找房", ResImages.image_home_op7));
    opItem.add(OpItemData("支付房租", ResImages.image_home_op8));
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        createChild(),
        new Container(
          height: 80.0,
          color: Colors.black26,
        ),
      ],
    );
  }

  Widget createChild() {
    return ListView.builder(itemBuilder: (c, index) {
      Widget item;
      if (index == 0) {
        item = new Container(
          height: 240.0,
          color: Colors.orangeAccent,
        );
      } else if (index == 1) {
        item = new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: opItem.sublist(0, 4).map((op) => barOpItem(op)).toList(),
        );
      } else if (index == 2) {
        item = new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: opItem.sublist(4, 8).map((op) => barOpItem(op)).toList(),
        );
      } else {
//        item = new Text("index->${index + 1}");
        item = new HouseInfoWidget(HouseInfoBean(houseName: "$index"));
      }
      return item;
    });
  }

  Widget itemOp() {
    return new GridView.count(
        crossAxisCount: 4,
        children: opItem.map((op) {
          return barOpItem(op);
        }).toList());
  }

  Widget barOpItem(OpItemData item) {
    return new Expanded(
      child: new InkWell(
        onTap: () {
//        itemBarClick(item);
        },
        child: Padding(
          padding: ResDimens.padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 40.0,
                height: 40.0,
                child: Image.asset(item.localImage),
              ),
              Padding(
                  padding: ResDimens.padding_left,
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black87,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
