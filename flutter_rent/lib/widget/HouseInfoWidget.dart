import 'package:flutter/material.dart';
import 'package:flutter_rent/Constants.dart';
import 'package:flutter_rent/widget/CommonWidget.dart';

class HouseInfoBean {
  final String houseId;
  final String houseName;
  final String houseImage;
  final String rent;
  final String special;
  final String detail;

  const HouseInfoBean(
      {this.houseId,
      this.houseName,
      this.houseImage,
      this.rent,
      this.special,
      this.detail});

  static HouseInfoBean formJson(String houseName) {
    return new HouseInfoBean(houseName: "房源名称->" + houseName);
  }

  factory HouseInfoBean.fromJson(Map<String, dynamic> json) {
    return new HouseInfoBean(
      houseId: json['userId'],
      houseName: json['id'],
    );
  }
}

class HouseInfoWidget extends StatelessWidget {
  final HouseInfoBean bean;

  const HouseInfoWidget(this.bean);

  @override
  Widget build(BuildContext context) {
    return new Flex(
      direction: Axis.vertical,
      children: <Widget>[
        new InkWell(
          child: Padding(
            padding: ResDimens.padding,
            child: content(),
          ),
          onTap: () {
            print("click-> ${bean.houseName}");
          },
        ),
        new Divider(
          height: 1.0,
          indent: ResDimens.dimen_pub_padding,
        ),
        CommonDivider.buildDividerLeft,
      ],
    );
  }

  Widget content() {
    return Row(
      children: <Widget>[
        SizedBox(
          height: 83.0,
          width: 110.0,
          child: new Container(
            color: Colors.blueAccent,
          ),
        ),
        Padding(
          padding: ResDimens.padding_left,
          child: Column(
            children: <Widget>[
              Text(
                bean.houseName,
                style: new TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: ResColors.color_text_333333),
              ),
            ],
          ),
        )
      ],
    );
  }
}
