import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yshz/base.dart';
import 'package:flutter_yshz/common/widget/bottom_nav_bar.dart';
import 'package:flutter_yshz/resource.dart';
import 'package:flutter_yshz/ui/home_page_car.dart';
import 'package:flutter_yshz/ui/home_page_main.dart';
import 'package:flutter_yshz/ui/home_page_mine.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with BaseConfig, AutomaticKeepAliveClientMixin {
  List<Widget> pages;
  List<ChooseItem> bottomItems;

  int _currentIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    pages = new List();
    pages.add(HomePageMain());
    pages.add(HomePageCar());
    pages.add(HomePageMine());

    bottomItems = new List();
    bottomItems.add(_createItem(
        0, "首页", ResImages.home_tab_home_n, ResImages.home_tab_home_h)
      ..choose = true);
    bottomItems.add(_createItem(1, "购物车", ResImages.home_tab_shop_car_n,
        ResImages.home_tab_shop_car_h));
    bottomItems.add(_createItem(
        2, "我的", ResImages.home_tab_mine_n, ResImages.home_tab_mine_h));
  }

  ChooseItem _createItem(
      int index, String title, String imageNor, String imageActive) {
    return new ChooseItem(title,
        index: index,
        imageResNor: imageNor,
        imageResActive: imageActive,
        callback: _itemClick,
        fontSize: 12.0,
        imageSize: 20.0,
        textColorNor: const Color(0xff8e8e8e),
        textColorActive: ResColors.colorPrimary);
  }

  var _pageController = PageController(keepPage: true);

  _itemClick(ChooseItem item) {
    int index = item.index;
    if (_currentIndex != index) {
      _currentIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 1), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ResColors.colorBg,
        body: PageView.builder(
          itemBuilder: (context, index) {
            return pages[index];
          },
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: pages.length,
        ),
        bottomNavigationBar: BottomAppBar(
          child: BottomNavBarWidget(
            items: bottomItems,
            defaultChooseItem: bottomItems[_currentIndex],
          ),
          elevation: 5.0,
        ));
  }
}
