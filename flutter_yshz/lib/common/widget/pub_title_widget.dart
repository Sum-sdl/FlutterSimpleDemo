import 'package:flutter/material.dart';

class PubTitleWidget extends StatefulWidget {
  final bool safeArea;
  final bool needBack;
  final String titleText;
  final Widget rightWidget;
  final double titleHeight;

  const PubTitleWidget(
      {Key key,
      this.safeArea = true,
      this.needBack = true,
      @required this.titleText,
      this.titleHeight = 56.0,
      this.rightWidget = const Text("")})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PubTitleWidgetState();
}

class _PubTitleWidgetState extends State<PubTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return buildCenter(context);
  }

  Widget buildCenter(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: widget.titleHeight,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              buildBack(),
              Center(
                  child: Text(
                widget.titleText,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: widget.rightWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBack() {
    if (widget.needBack) {
      return IconButton(
          icon: const BackButtonIcon(),
          color: Colors.white,
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () {
            Navigator.maybePop(context);
          });
    } else {
      return const Text("");
    }
  }
}
