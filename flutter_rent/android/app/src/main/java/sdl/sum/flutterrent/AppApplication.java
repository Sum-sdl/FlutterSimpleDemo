package sdl.sum.flutterrent;

import android.app.Activity;
import android.support.annotation.CallSuper;

import com.sum.library.app.BaseApplication;

import io.flutter.view.FlutterMain;

/**
 * Created by sdl on 2018/11/15.
 */
public class AppApplication extends BaseApplication {
    private Activity mCurrentActivity = null;

    public AppApplication() {
    }

    @CallSuper
    public void onCreate() {
        super.onCreate();
        FlutterMain.startInitialization(this);
    }

    public Activity getCurrentActivity() {
        return this.mCurrentActivity;
    }

    public void setCurrentActivity(Activity mCurrentActivity) {
        this.mCurrentActivity = mCurrentActivity;
    }
}
