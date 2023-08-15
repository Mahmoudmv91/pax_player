package module;


import com.pax.dal.ISys;
import com.pax.dal.entity.BaseInfo;
import com.pax.dal.entity.EBeepMode;
import com.pax.dal.entity.ENavigationKey;
import com.pax.dal.entity.ETermInfoKey;
import com.pax.dal.entity.ETouchMode;

import java.util.Locale;
import java.util.Map;

import pax.plugin.pki.parhamkish.vakili.pax_player.PaxApp;
import utils.BasePax;

public class SysPax extends BasePax {

    private static SysPax sysPax;
    private ISys iSys = null;

    private SysPax() {
        iSys = PaxApp.getDal().getSys();
    }

    public static SysPax getInstance() {
        if (sysPax == null) {
            sysPax = new SysPax();
        }
        return sysPax;
    }

    public void beep(final EBeepMode beepMode, final int delayTime) {
        iSys.beep(beepMode, delayTime);
        logTrue("beep");
    }

    public String getTerminfo() {
        Map<ETermInfoKey, String> termInfo = iSys.getTermInfo();
        logTrue("getTerminfo");
        StringBuilder termInfoStr = new StringBuilder();
        for (ETermInfoKey key : ETermInfoKey.values()) {
            termInfoStr.append(key.name()).append(":").append(termInfo.get(key)).append("\n");
        }
        return termInfoStr.toString();
    }

//    public String getRadom(int len) {
//        byte[] random = iSys.getRandom(len);
//        if (random != null) {
//            logTrue("getRadom");
//            return Convert.getInstance().bcdToStr(random);
//        } else {
//            logErr("getRadom", "return null");
//            return "null";
//        }
//
//    }

//    public String getDevInterfaceVer() {
//        String verString = iSys.getDevInterfaceVer();
//        logTrue("getDevInterfaceVer");
//        return "version of device interface:" + verString;
//    }

    public void showNavigationBar(boolean flag) {
        iSys.showNavigationBar(flag);
        logTrue("showNavigationBar");
    }

    public void enableNavigationBar(boolean flag) {
        iSys.enableNavigationBar(flag);
        logTrue("enableNavigationBar");
    }

//    public void enableNavigationKey(ENavigationKey navigationKey, boolean flag) {
//        iSys.enableNavigationKey(navigationKey, flag);
//        logTrue("enableNavigationKey");
//    }
//
//    public boolean isNavigationBarVisible() {
//        boolean res = true;
//        res = iSys.isNavigationBarVisible();
//        logTrue("isNavigationBarVisible");
//        return res;
//    }
//
//    public boolean isNavigationBarEnabled() {
//        boolean res = true;
//        res = iSys.isNavigationBarEnabled();
//        logTrue("isNavigationBarEnabled");
//        return res;
//    }
//
//    public boolean isNavigationKeyEnabled(ENavigationKey navigationKey) {
//        boolean res = true;
//        res = iSys.isNavigationKeyEnabled(navigationKey);
//        logTrue("isNavigationKeyEnabled");
//        return res;
//    }

    public void showStatusBar(boolean flag) {
        iSys.showStatusBar(flag);
        logTrue("showStatusBar");
    }

    public void enableStatusBar(boolean flag) {
        iSys.enableStatusBar(flag);
        logTrue("enableStatusBar");
    }

//    public boolean isStatusBarEnabled() {
//        boolean res = true;
//        res = iSys.isStatusBarEnabled();
//        logTrue("isStatusBarEnabled");
//        return res;
//    }
//
//    public boolean isStatusBarVisible() {
//        boolean res = true;
//        res = iSys.isStatusBarVisible();
//        logTrue("isStatusBarVisible");
//        return res;
//    }

    public void resetStatusBar() {
        iSys.resetStatusBar();
        logTrue("resetStatusBar");
    }

//    public void enablePowerKey(boolean flag) {
//        iSys.enablePowerKey(flag);
//        logTrue("enablePowerKey");
//    }
//
//    public boolean isPowerKeyEnabled() {
//        boolean res = true;
//        res = iSys.isPowerKeyEnabled();
//        logTrue("isPowerKeyEnabled");
//        return res;
//    }
//
//    public void setSettingsNeedPassword(boolean flag) {
//        iSys.setSettingsNeedPassword(flag);
//        logTrue("setSettingsNeedPassword");
//    }
//
//    public void reboot() {
//        iSys.reboot();
//        logTrue("reboot");
//    }
//
//    public void shutdown() {
//        iSys.shutdown();
//        logTrue("shutdown");
//    }
//
//    public void switchTouchMode(ETouchMode touchMode) {
//        iSys.switchTouchMode(touchMode);
//        logTrue("switchTouchMode");
//    }
//
//    public int getAppLogs(String storePath, String startDate, String endDate) {
//        int res = iSys.getAppLogs(storePath, startDate, endDate);
//        logTrue("getAppLogs");
//        return res;
//    }
//
//    public String readTUSN() {
//        String res = iSys.readTUSN();
//        logTrue("readTUSN");
//        return res;
//    }
//
//    public boolean isOnBase(){
//        boolean isOnBase = iSys.isOnBase();
//        logTrue("isOnBase");
//        return isOnBase;
//    }
//
//    public BaseInfo getBaseInfo(){
//        BaseInfo baseInfo = iSys.getBaseInfo();
//        logTrue("getBaseInfo");
//        return baseInfo;
//    }
//
//    public String getSystemLanguage(){
//        String language = iSys.getSystemLanguage();
//        logTrue("getSystemLanguage");
//        return language;
//    }
//
//    public void setSystemLanguage(Locale locale){
//        iSys.setSystemLanguage(locale);
//        logTrue("setSystemLanguage");
//    }
//
//    public String getPN(){
//        String pn = iSys.getPN();
//        logTrue("getPN");
//        return pn;
//    }
}
