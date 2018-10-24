import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef SizeChangedCallback = void Function(Size size);

class Notifier extends SingleChildRenderObjectWidget {
  const Notifier({
    Key key,
    Widget child,
    this.callBack,
  }) : super(key: key, child: child);
  final SizeChangedCallback callBack;

  @override
  _RenderSizeChangedWithCallback createRenderObject(BuildContext context) {
    return _RenderSizeChangedWithCallback(
        onLayoutChangedCallback: () {
          SizeChangedLayoutNotification().dispatch(context);
        },
        callBack: callBack);
  }
}

class _RenderSizeChangedWithCallback extends RenderProxyBox {
  _RenderSizeChangedWithCallback({
    RenderBox child,
    @required this.onLayoutChangedCallback,
    this.callBack,
  })  : assert(onLayoutChangedCallback != null),
        super(child);

  final VoidCallback onLayoutChangedCallback;
  final SizeChangedCallback callBack;

  Size _oldSize;

  @override
  void performLayout() {
    super.performLayout();
    // Don't send the initial notification, or this will be SizeObserver all
    if (_oldSize != null && size != _oldSize) {
      onLayoutChangedCallback();
      callBack(size);
    }
    // over again!
    _oldSize = size;
  }
}
