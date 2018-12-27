import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_yshz/bloc/sort_bloc.dart';
import 'package:flutter_yshz/resource.dart';

typedef AdvCallBack = Function(Adv ad);

class BannerAdv extends StatelessWidget {
  final List<Adv> adv;
  final AdvCallBack function;
  final double padding;

  const BannerAdv({Key key, this.adv, this.function, this.padding = 12.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (adv == null) {
      return Text("");
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(padding),
      width: double.infinity,
      height: 240.0,
      child: new Swiper(
        autoplayDelay: 4000,
        duration: 500,
        autoplay: false,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              function(adv[index]);
            },
            child: showNetImageWidgetImgCustom(
                adv[index].bImg, ResImages.image_error),
          );
        },
        itemCount: adv.length,
        pagination: new SwiperPagination(
            builder:
                const DotSwiperPaginationBuilder(size: 5.0, activeSize: 5.0)),
      ),
    );
  }

  Widget showNetImageWidgetImgCustom(String url, String imgRes) {
    if (url == null || url.length == 0) {
      return Image.asset(imgRes);
    }
    return CachedNetworkImage(
      imageUrl: url,
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: Image.asset(
        ResImages.image_error,
        fit: BoxFit.cover,
      ),
      errorWidget: Image.asset(imgRes, fit: BoxFit.cover),
      fit: BoxFit.fill,
    );
  }
}
