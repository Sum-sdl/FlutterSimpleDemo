package sdl.sum.flutterrent;

import android.os.Build;
import android.os.Bundle;
import android.os.Handler;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StringCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {//API>21,设置状态栏颜色透明
//            getWindow().setStatusBarColor(0);
//        }
        GeneratedPluginRegistrant.registerWith(this);
        //add self method
        //方式1.1
//        AppUtilsFlutterPlugin.registerWith(this.registrarFor("sdl.sum.flutterrent.AppUtilsFlutterPlugin"));

        //方式1.2
        MethodChannel channel = new MethodChannel(getFlutterView(), "sum.flutter.utils/device");
        channel.setMethodCallHandler(new AppUtilsFlutterPlugin(this.registrarFor("111111")));

        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                sendToFlutter();
            }
        }, 12000);
    }

    private String flutter_channel = "push";

    //主动发消息给flutter
    private void sendToFlutter() {
        BasicMessageChannel<String> app = new BasicMessageChannel<>(getFlutterView(), flutter_channel, StringCodec.INSTANCE);
        app.send("Send Msg From Android App");
    }
}
