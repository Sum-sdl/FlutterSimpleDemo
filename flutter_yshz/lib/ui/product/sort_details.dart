import 'package:flutter/material.dart';
import 'package:flutter_yshz/base.dart';
import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/bloc/sort_bloc.dart';
import 'package:flutter_yshz/common/widget/pub_title_widget.dart';
import 'package:flutter_yshz/resource.dart';

class GoodDetails extends StatefulWidget {
  final String title;
  final String sortId;

  const GoodDetails({Key key, this.title = "", this.sortId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GoodDetailsState();
}

class _GoodDetailsState extends State<GoodDetails>
    with BaseConfig, AutoBlocMixin {
  SortBloc _carBloc;

  @override
  SortBloc get bloc => _carBloc;

  @override
  void initState() {
    _carBloc = SortBloc(widget.sortId, type: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResColors.colorBg,
      body: Column(
        children: <Widget>[
          PubTitleWidget(
            titleText: widget.title,
          ),
          Expanded(
            child: StreamBuilder(
                stream: bloc.stream,
                builder: (BuildContext c, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    return buildChild(snap.data);
                  } else if (snap.hasError) {
                    return showErrorWidget();
                  } else {
                    return showLoadingWidget();
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget buildChild(Good data) {
    return Center(
      child: Text("Hello+ ${widget.title}"),
    );
  }
}
