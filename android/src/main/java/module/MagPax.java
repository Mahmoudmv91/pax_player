package module;



import com.pax.dal.IMag;
import com.pax.dal.entity.TrackData;
import com.pax.dal.exceptions.MagDevException;

import pax.plugin.pki.parhamkish.vakili.pax_player.PaxApp;
import utils.BasePax;

public class MagPax extends BasePax {

    private static MagPax magPax;

    private IMag iMag;

    private MagPax() {
        iMag = PaxApp.getDal().getMag();
    }

    public static MagPax getInstance() {
        if (magPax == null) {
            magPax = new MagPax();

        }
        return magPax;
    }

    public void open() {
        try {
            iMag.open();
            logTrue("open");
        } catch (MagDevException e) {
            e.printStackTrace();
            logErr("open", e.toString());
        }
    }

    public void close() {
        try {
            iMag.close();
            logTrue("close");
        } catch (MagDevException e) {
            e.printStackTrace();
            logErr("close", e.toString());
        }
    }

    // Reset magnetic stripe card reader, and clear buffer of magnetic stripe card.
    public void reset() {
        try {
            iMag.reset();
            logTrue("reSet");
        } catch (MagDevException e) {
            e.printStackTrace();
            logErr("reSet", e.toString());
        }
    }

    // Check whether a card is swiped
    public boolean isSwiped() {
        boolean b = false;
        try {
            b = iMag.isSwiped();
            // logTrue("isSwiped");
        } catch (MagDevException e) {
            e.printStackTrace();
            logErr("isSwiped", e.toString());
        }
        return b;
    }

    public TrackData read() {
        try {
            TrackData trackData = iMag.read();
            logTrue("read");
            return trackData;
        } catch (MagDevException e) {
            e.printStackTrace();
            logErr("read", e.toString());
            return null;
        }
    }

}


//        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//                .setMethodCallHandler(
//                        (call, result) -> {
//
//                            // This method is invoked on the main thread.
//                            // TODO
//                            if (call.method.equals("getCardNumber")) {
//                                if (magReadThread == null) {
////                                    result.success("لطفا کارت را بکشید");
//                                    magReadThread = new MagReadThread(result);
//
//                                    MagTester.getInstance().open();
//                                    MagTester.getInstance().reset();
////
//                                    magReadThread.start();
////                                }
//
//                                } else {
////                                    result.success("لطفا کارت را بکشید");
//                                    magReadThread = new MagReadThread(result);
//                                    MagTester.getInstance().close();
//                                    MagTester.getInstance().open();
//                                    MagTester.getInstance().reset();
////
//                                    magReadThread.start();
//
//                                }
////                            else if(call.method.equals("resetCardNumber")){
////                                MagTester.getInstance().reset();
////                                result.success("کارت را بکشید");
////                            }
//                            }
////                            if (cardNumber.length() > 16) {
//
////                                result.success(cardNumber);
////                            }
//
//                        }
//                );

//        if (magReadThread == null) {
//            magReadThread = new MagReadThread();
//
//            MagTester.getInstance().open();
//            MagTester.getInstance().reset();
//            magReadThread.start();
//        }