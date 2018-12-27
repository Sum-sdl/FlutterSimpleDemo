import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_yshz/base.dart';
import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/bloc/home_bloc.dart';
import 'package:flutter_yshz/common/widget/pub_title_widget.dart';

class HomePageMine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMine>
    with BaseConfig, AutomaticKeepAliveClientMixin, AutoBlocMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  HomeBloc get bloc => null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PubTitleWidget(
          titleText: "我的",
          needBack: false,
        ),
        Expanded(
          child: RefreshIndicator(
              backgroundColor: Colors.blue,
              child: Center(child: Text("空文本")),
              onRefresh: _refreshLoadData),
        ),
      ],
    );
  }

  Future<void> _refreshLoadData() async {
    print("Hello empty ");
    return new Completer<Null>()..complete(null);
  }
}
