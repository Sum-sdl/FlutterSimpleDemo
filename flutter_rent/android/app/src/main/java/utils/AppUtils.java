package utils;

import android.annotation.SuppressLint;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.widget.Toast;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.UUID;

/**
 * Created by sdl on 2017/12/27.
 */

public class AppUtils {

    //获取唯一id，可以不用权限
    @SuppressLint({"MissingPermission", "HardwareIds"})
    public static String getAppUniqueUUID() {
        String serial = null;
        String devId = "35" +
                Build.BOARD.length() % 10 + Build.BRAND.length() % 10 +
                Build.CPU_ABI.length() % 10 + Build.DEVICE.length() % 10 +
                Build.DISPLAY.length() % 10 + Build.HOST.length() % 10 +
                Build.ID.length() % 10 + Build.MANUFACTURER.length() % 10 +
                Build.MODEL.length() % 10 + Build.PRODUCT.length() % 10 +
                Build.TAGS.length() % 10 + Build.TYPE.length() % 10 +
                Build.USER.length() % 10; //13 位
        try {
            if (Build.VERSION.SDK_INT >= 27) {
                serial = "serial_android";
            } else {
                serial = Build.SERIAL;
            }
            return new UUID(devId.hashCode(), serial.hashCode()).toString();
        } catch (Exception exception) {
            //serial需要一个初始化
            serial = "serial_android";
        }
        //使用硬件信息拼凑出来的15位号码
        return new UUID(devId.hashCode(), serial.hashCode()).toString();
    }

    public static void toastUtils(Context context, String msg) {
        if (!TextUtils.isEmpty(msg)) {
            Toast.makeText(context.getApplicationContext(), msg, Toast.LENGTH_LONG).show();
        }
    }

    /**
     * 通知到系统上下文中
     */
    public static void displayToGallery(Context context, File photoFile) {
        if (photoFile == null || !photoFile.exists()) {
            return;
        }
        String photoPath = photoFile.getAbsolutePath();
        String photoName = photoFile.getName();
        // 其次把文件插入到系统图库
        try {
            ContentResolver contentResolver = context.getContentResolver();
            MediaStore.Images.Media.insertImage(contentResolver, photoPath, photoName, null);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        // 最后通知图库更新
        context.sendBroadcast(new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.parse("file://" + photoPath)));
    }
}
