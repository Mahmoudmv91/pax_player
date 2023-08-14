package utils;

import android.util.Log;

public class BaseTester {

    private String childName = "";

    public BaseTester() {
        
    }

    public void logTrue(String method) {
        childName = getClass().getSimpleName() + ".";
        String trueLog = childName + method;
        Log.i("IPPITest", trueLog);
        //clear();
//        FloatView.appendLog("true:"+trueLog + "\n");
    }

    public void logErr(String method, String errString) {
        childName = getClass().getSimpleName() + ".";
        String errorLog = childName + method + "   errorMessage：" + errString;
        Log.e("IPPITest", errorLog);
        //clear();
//        FloatView.appendLog("error:"+errorLog + "\n");
    }

    public void clear() {
//        FloatView.clearLog();
    }

//    public String getLog() {
//        return FloatView.logStr.equals("") ? "Log" : FloatView.logStr;
//    }

}
