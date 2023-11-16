package pax.plugin.pki.parhamkish.vakili.pax_player;

import static java.lang.Byte.parseByte;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.SystemClock;
import android.util.Log;

import androidx.annotation.NonNull;

import com.pax.dal.IScannerHw;
import com.pax.dal.entity.EBeepMode;
import com.pax.dal.entity.EFontTypeAscii;
import com.pax.dal.entity.EFontTypeExtCode;
import com.pax.dal.entity.ScanResult;
import com.pax.dal.entity.TrackData;
import com.pax.dal.exceptions.ScannerHwDevException;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import module.MagPax;
import module.PrinterPax;
import module.SysPax;
import utils.QRCodeUtil;

/**
 * PaxPlayerPlugin
 */
public class PaxPlayerPlugin implements FlutterPlugin, MethodCallHandler {

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private static PrinterPax printerPax;
    private static QRCodeUtil qrCodeUtil;
    static String cardNumber = "کارت را بکشید";
    private IScannerHw mIScannerHw;
    private static final String CHANNEL = "pax.plugin.pki.parhamkish.vakili.pax_player/pax_reader";

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), CHANNEL);
        channel.setMethodCallHandler(this);
        printerPax = PrinterPax.getInstance();
        mIScannerHw = PaxApp.getDal().getScannerHw();
        qrCodeUtil = new QRCodeUtil();

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

        switch (call.method) {
            case "getCardNumber":
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
                break;
            case "getBarcode":

                Handler handlerScan = new Handler(Looper.getMainLooper());

                Thread scanThread = new Thread(() -> {


                    if (null != mIScannerHw) {
                        try {
                            mIScannerHw.open();

                            ScanResult scanResult = mIScannerHw.read(10000);

                            if (!Thread.interrupted()) {
                                if (null != scanResult) {
                                    String message=scanResult.getContent();
                                    handlerScan.post(() -> result.success(message));
                                }
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }



                    SystemClock.sleep(100);


                });


                scanThread.start();
                break;
            case "getBeep":
                Integer delayTime = call.argument("time");
                try {
                    SysPax.getInstance().beep(EBeepMode.FREQUENCE_LEVEL_6, delayTime != null ? delayTime : 10);
                    result.success(true);
                } catch (Exception error) {
                    Log.i("beep-pax", error.toString());
                }
                break;
            case "getDeviceInfo":
                try {

                    final String info = SysPax.getInstance().getTerminfo();


                    result.success(info);
                } catch (Exception error) {
                    Log.i("beep-pax", error.toString());
                }
                break;
            case "setEnableNavBar":
                boolean state = Boolean.TRUE.equals(call.argument("state"));
                try {

                    SysPax.getInstance().showNavigationBar(state);
                    SysPax.getInstance().enableNavigationBar(state);
                    SysPax.getInstance().showStatusBar(state);
                    SysPax.getInstance().enableStatusBar(state);


                    result.success(true);
                } catch (Exception error) {
                    Log.i("beep-pax", error.toString());
                }
                break;
            case "init":
                printerPax.init();
                result.success(true);

                break;
            case "getStatus": {
                String status = printerPax.getStatus();
                result.success(status);

                break;
            }
            case "start": {


                final String status = printerPax.start();
                result.success(status);


                break;
            }
            case "setGray":


                Integer level = call.argument("level");
                printerPax.setGray(level != null ? level : 10);
                result.success(true);


                break;
            case "printBitmap":


                byte[] bytes = call.argument("bitmap");
                assert bytes != null;
                Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
                printerPax.printBitmap(bitmap);
                printerPax.printStr("\n\n\n\n\n", null);
                result.success(true);


                break;
            case "printNormal":

                Log.i("paxxx", "ok");
//            printerPax.init();
                printerPax.fontSet(EFontTypeAscii.FONT_8_16, EFontTypeExtCode.FONT_16_16);
//            printerPax.setGray(1);

                Log.i("paxxx", "ok3");
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                    printerPax.printStr("تست فارسی", null);
                    printerPax.start();
                    Log.i("paxxx", "ok4");
                }
                result.success(true);
                Log.i("paxxx", "ok5");


                break;
            case "printReceipt": {
//            String content = call.argument("content");

                printerPax.init();
                printerPax.fontSet(EFontTypeAscii.FONT_8_16, EFontTypeExtCode.FONT_16_16);
                printerPax.spaceSet(parseByte("0"), parseByte("10"));
                printerPax.setGray(1);

                printerPax.printBitmap(QRCodeUtil.encodeAsBitmap("پرینت تست حروف فارسی", 512, 512));
                printerPax.printStr("", null);
                printerPax.step(150);
                final String status = printerPax.start();
                result.success(status);

                break;
            }
            case "printReceiptWithQr": {
                String content = call.argument("content");
                String qrContent = call.argument("qr_content");

                printerPax.init();
                printerPax.fontSet(EFontTypeAscii.FONT_8_16, EFontTypeExtCode.FONT_16_16);
                printerPax.spaceSet(parseByte("0"), parseByte("10"));
                printerPax.setGray(1);
                printerPax.printStr(content, null);
                printerPax.printStr("", null);
                if (qrContent != null) {
                    printerPax.printBitmap(QRCodeUtil.encodeAsBitmap(qrContent, 512, 512));
                    printerPax.printStr("", null);
                }
                printerPax.step(150);
                final String status = printerPax.start();
                result.success(status);

                break;
            }
            default:
                result.notImplemented();
                break;
        }

    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
