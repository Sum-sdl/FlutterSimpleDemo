import 'package:flutter/services.dart';

class FlutterReceiver {
  static const String plugin_name = "push";

  static const BasicMessageChannel<String> PUSH =
      const BasicMessageChannel(plugin_name, const StringCodec());

  static const BasicMessageChannel<String> lifecycle =
      const BasicMessageChannel("flutter/lifecycle", const StringCodec());
}
