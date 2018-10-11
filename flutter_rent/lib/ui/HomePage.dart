import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rent/Constants.dart';
import 'package:flutter_rent/net/Api.dart';
import 'package:flutter_rent/net/DioFactory.dart';
import 'package:flutter_rent/utils/Utils.dart';
import 'package:flutter_rent/widget/HouseInfoWidget.dart';

class HomeView extends StatelessWidget {
  const HomeView();

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

  const OpItemData(this.name, this.localImage);
}

class _HomePageState extends State<_HomePage> {
  List<OpItemData> opItem;

  _loadData(String tag) async {
    print("_loadData ->" + tag);

    Map<String, String> p = new Map();
    p["city"] = "nj";
    p["device_id"] = "ffffffff-8650-ca15-ffff-ffffd8967aa8";

    Dio dio = await DioFactory.getInstance().getDio();
    dio.options.data = p; //请求参数

    Response response = await dio.get(Api.home);

    print(response.toString());
  }

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

    _scrollController = new ScrollController()
      ..addListener(_scrollListener);
    _loadData("initState");
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  ScrollController _scrollController;

  Color titleBg = Color(0x00FFFFFF);

  //滚动偏移量
  void _scrollListener() {
    double distance = _scrollController.offset;
//    titleWidget._scrollChange(distance);
    double opacity = Utils.progressPercent(distance.round(), 118);
    int alpha = (255.0 * opacity).round();
    if (titleBg.alpha == alpha) {
      return;
    }
    setState(() {
      titleBg = titleBg.withOpacity(opacity);
    });
  }

  TitleWidget titleWidget;

  @override
  Widget build(BuildContext context) {
    print("build ->${titleBg.alpha}");
    titleWidget = TitleWidget();
    return new Stack(
      children: <Widget>[
        createChild(),
        titleWidget,
      ],
    );
  }

  Widget createChild() {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        itemBuilder: (c, index) {
          Widget item;
          if (index == 0) {
            item = new Container(
              height: 180.0,
              color: Colors.orangeAccent,
            );
          } else if (index == 1) {
            item = new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: opItem.sublist(0, 4)
                  .map((op) => barOpItem(op))
                  .toList(),
            );
          } else if (index == 2) {
            item = new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: opItem.sublist(4, 8)
                  .map((op) => barOpItem(op))
                  .toList(),
            );
          } else {
            item = new HouseInfoWidget(HouseInfoBean(houseName: "$index"));
          }
          return item;
        });
  }

  Widget barOpItem(OpItemData item) {
    return new Expanded(
      child: new InkWell(
        onTap: () {
          _loadData(item.name);
        },
        child: Padding(
          padding: ResDimens.padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 38.0,
                height: 38.0,
                child: Image.asset(item.localImage),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: ResColors.color_text_666666,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleWidget extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return new TitleWidgetState();
  }
}

class TitleWidgetState extends State<TitleWidget> {

  Color titleBg = Color(0x00FFFFFF);

  //滚动偏移量
  void scrollListener(double distance) {
    double opacity = Utils.progressPercent(distance.round(), 118);
    int alpha = (255.0 * opacity).round();
    if (titleBg.alpha == alpha) {
      return;
    }
    setState(() {
      titleBg = titleBg.withOpacity(opacity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 80.0,
      color: titleBg,
    );
  }
}
