package sdl.sum.flutterrent;


import android.util.Log;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import utils.AppUtils;

/**
 * Created by sdl on 2018/10/19.
 * 自定义平台方法实现
 */
public class AppUtilsFlutterPlugin implements MethodChannel.MethodCallHandler {

    /**
     * 注册MethodChannel方法实现类
     */
    public static void registerWith(PluginRegistry.Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "sum.flutter.utils/device");
        channel.setMethodCallHandler(new AppUtilsFlutterPlugin(registrar));
    }

    private PluginRegistry.Registrar mRegistrar;

    public AppUtilsFlutterPlugin(PluginRegistry.Registrar registrar) {
        this.mRegistrar = registrar;
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "getPlatformVersion":
                result.success("Android= " + android.os.Build.VERSION.RELEASE);
                break;
            case "getAppUniqueUUID":
                result.success(AppUtils.getAppUniqueUUID());
                break;
            case "showToast":
                Log.e("main", "toast channel msg->" + call.method + "," + call.arguments + ",," + call.toString());
                AppUtils.toastUtils(mRegistrar.context(), call.argument("msg").toString());
                result.success("");
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
