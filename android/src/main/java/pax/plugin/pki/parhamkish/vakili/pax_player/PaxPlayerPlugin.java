package pax.plugin.pki.parhamkish.vakili.pax_player;

import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.util.Log;

import androidx.annotation.NonNull;

import com.pax.dal.entity.EBeepMode;
import com.pax.dal.entity.TrackData;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import module.MagPax;
import module.SysPax;

/**
 * PaxPlayerPlugin
 */
public class PaxPlayerPlugin implements FlutterPlugin, MethodCallHandler {

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    static String cardNumber = "کارت را بکشید";
    private static final String CHANNEL = "pax.plugin.pki.parhamkish.vakili.pax_player/pax_reader";

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), CHANNEL);
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

        if (call.method.equals("getCardNumber")) {
            MagPax.getInstance().open();
            MagPax.getInstance().reset();
            Handler handler = new Handler(Looper.getMainLooper());
            Thread thread = new Thread(() -> {
                try {
                    while (!Thread.interrupted()) {
                        if (MagPax.getInstance().isSwiped()) {
                            TrackData trackData = MagPax.getInstance().read();
                            if (trackData != null) {
                                String resStr = "";
                                if (trackData.getResultCode() == 0) {
                                    resStr = "خطا";

                                    cardNumber = resStr;

                                    continue;
                                }
                                if ((trackData.getResultCode() & 0x01) == 0x01) {
                                    resStr += trackData.getTrack1();

                                    cardNumber = resStr;
                                }
                                if ((trackData.getResultCode() & 0x02) == 0x02) {
                                    resStr += trackData.getTrack2();

                                    cardNumber = resStr;
                                }
                                if ((trackData.getResultCode() & 0x04) == 0x04) {
                                    resStr += trackData.getTrack3();

                                    cardNumber = resStr;
                                }

                                final String finalResStr = resStr;
                                handler.post(() -> result.success(finalResStr));
                                break;
                            }

                        }


                        SystemClock.sleep(100);
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            });
            thread.start();
        } else if (call.method.equals("getBeep")) {
            int delayTime = call.argument("time");
            try {
                SysPax.getInstance().beep(EBeepMode.FREQUENCE_LEVEL_6, delayTime);
                result.success(true);
            } catch (Exception error) {
                Log.i("beep-pax", error.toString());
            }
        } else if (call.method.equals("getDeviceInfo")) {
            try {

                final String info = SysPax.getInstance().getTerminfo();

                result.success(info);
            } catch (Exception error) {
                Log.i("beep-pax", error.toString());
            }
        } else if (call.method.equals("setEnableNavBar")) {
            boolean state=call.argument("state");
            try {

                SysPax.getInstance().showNavigationBar(state);
                SysPax.getInstance().enableNavigationBar(state);
                SysPax.getInstance().showStatusBar(state);
                SysPax.getInstance().enableStatusBar(state);


                result.success(true);
            } catch (Exception error) {
                Log.i("beep-pax", error.toString());
            }
        }  else {
            result.notImplemented();
        }

    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
