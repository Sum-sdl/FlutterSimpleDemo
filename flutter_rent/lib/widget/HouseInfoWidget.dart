import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rent/Constants.dart';
import 'package:flutter_rent/utils/RouteHelper.dart';
import 'package:flutter_rent/widget/CommonWidget.dart';

class HouseInfoBean {
  final String houseId;
  final String houseName;
  final String houseImage;
  final String houseRoom;
  final String houseLocation;
  final List<String> houseTag;
  final String rent;

  const HouseInfoBean({this.houseId,
    this.houseName = "houseName",
    this.houseImage = "",
    this.houseRoom = "houseRoom",
    this.houseLocation = "houseLocation",
    this.houseTag,
    this.rent = "rent"});

  static HouseInfoBean formJson(String houseName) {
    return new HouseInfoBean(houseName: "房源名称->" + houseName);
  }

  factory HouseInfoBean.fromJson(Map<String, dynamic> json) {
    return new HouseInfoBean(
      houseId: json['h_id'].toString(),
      houseName: json['xiaoqu_name'],
      houseImage: json['list_images'],
      houseLocation: json['address'],
      rent: json['r_rent'].toString() + json['rent_intro'],
      houseRoom: json['room'].toString() +
          "室" +
          json['hall'].toString() +
          "厅" +
          json['toilet'].toString() +
          "卫",
    );
  }
}

class HouseInfoWidget extends StatelessWidget {
  final HouseInfoBean data;

  const HouseInfoWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RouteHelper.route2Detail(context, data.houseId);
      },
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(padding: ResDimens.padding, child: content()),
        CommonDivider.buildDividerLeft,
      ],
      ),);
  }

  Widget content() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 84.0,
          width: 110.0,
          child: getImage(),
        ),
        Expanded(child: Padding(
          padding: ResDimens.padding_left,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data.houseName,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: ResColors.color_text_333333),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  data.houseRoom,
                  style: TextStyle(fontSize: 13.0),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                  data.houseLocation + data.houseLocation,
                  style: TextStyle(fontSize: 13.0, inherit: true),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Row(
                  children: <Widget>[
                    data.houseTag == null
                        ? Text("")
                        : data.houseTag.map((it) {
                      return Text(it);
                    }).toList()
                  ],
                ),
              )
            ],
          ),
        )),
      ],
    );
  }

  Widget getImage() {
    if (data.houseImage == null || data.houseImage.length == 0) {
      return Image.asset(ResImages.image_error);
    }
    return CachedNetworkImage(
      imageUrl: data.houseImage,
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: Image.asset(ResImages.image_error),
      errorWidget: Image.asset(ResImages.image_error),
      width: 110.0,
      height: 84.0,
      fit: BoxFit.fill,
    );
  }
}
