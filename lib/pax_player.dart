import 'pax_player_platform_interface.dart';

class PaxPlayer {
  Future<String?> getCardNumber() {
    return PaxPlayerPlatform.instance.getCardNumber();
  }

  Future<bool?> getBeep(int time) {
    return PaxPlayerPlatform.instance.getBeep(time);
  }


  Future<String?> getDeviceInfo() {
    return PaxPlayerPlatform.instance.getDeviceInfo();
  }

  Future<bool?> setDisableNavBar() {
    return PaxPlayerPlatform.instance.setDisableNavBar();
  }

  Future<bool?> setEnableNavBar() {
    return PaxPlayerPlatform.instance.setEnableNavBar();
  }
}
