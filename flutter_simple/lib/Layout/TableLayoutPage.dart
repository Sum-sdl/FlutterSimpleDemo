import 'package:flutter/material.dart';

class TableLayoutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TablePage();
  }
}

class _TablePage extends State<TableLayoutPage> {
  @override
  Widget build(BuildContext context) {
    var con = Container(
      color: Colors.orange,
      child: Text("AA1"),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("TablePage"),
      ),
      body: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(50.0),
          1: FixedColumnWidth(100.0),
          2: FixedColumnWidth(50.0),
          3: FixedColumnWidth(100.0),
          5: FixedColumnWidth(150.0),
        },
        border: TableBorder.all(
            color: Colors.red, width: 1.0, style: BorderStyle.solid),
        children: const <TableRow>[
          TableRow(
            children: <Widget>[
              Text('B1'),
              Text('B1'),
              Text('C1'),
              Text('D1'),
              Text('E1'),
            ],
          ),
          TableRow(
            children: <Widget>[
              Text('A2'),
              Text('B2'),
              Text('C2'),
              Text('D2'),
              Text('E1'),
            ],
          ),
          TableRow(
            children: <Widget>[
              Text('A3'),
              Text('B3'),
              Text('C3'),
              Text('D3'),
              Text('E1'),
            ],
          ),
        ],
      ),
    );
  }
}

class FlowWarpLayoutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _WarpPage();
  }
}

class _WarpPage extends State<FlowWarpLayoutPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("WarpPage"),
      ),
      body: _flowCreate(),
    );
  }

  _flowCreate() {
    const width = 70.0;
    const height = 90.0;

    return Flow(
      delegate:
          TestFlowDelegate(margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)),
      children: <Widget>[
        new Container(
          width: width,
          height: height,
          color: Colors.yellow,
        ),
        new Container(
          width: width,
          height: height,
          color: Colors.green,
        ),
        new Container(
          width: width,
          height: height,
          color: Colors.red,
        ),
        new Container(
          width: width,
          height: height,
          color: Colors.black,
        ),
        new Container(
          width: width,
          height: height,
          color: Colors.blue,
        ),
        new Container(
          width: width,
          height: height,
          color: Colors.lightGreenAccent,
        ),
      ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    print("x->$x,y->$y");
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      print("w->$w,cW->${context.size.width}");
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
