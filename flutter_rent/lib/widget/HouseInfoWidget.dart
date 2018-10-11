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

//  final dynamic data;

  const HouseInfoWidget(this.bean);

  @override
  Widget build(BuildContext context) {
    return new Flex(
      direction: Axis.vertical,
      children: <Widget>[
        new InkWell(
          child: Padding(
            padding: ResDimens.padding,
              child: Container(child: content(), color: Colors.grey,)
          ),
          onTap: () {
            print("click-> ${bean.houseName}");
          },
        ),
        CommonDivider.buildDividerLeft,
      ],
    );
  }

  Widget content() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 83.0,
          width: 110.0,
          child: getImage(),
        ),
        Container(
          child: Padding(
            padding: ResDimens.padding_left,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  bean.houseName,
                  style: new TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: ResColors.color_text_333333),
                ),


              ],
            ),
          ),
          color: Colors.blueAccent,
        )
      ],
    );
  }

  Widget getImage() {
    if (bean.houseImage == null || bean.houseImage.length == 0) {
      return Image.asset(ResImages.image_error);
    }
    return new Image.network(bean.houseImage);
  }
}
