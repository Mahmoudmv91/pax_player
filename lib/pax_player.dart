import 'pax_player_platform_interface.dart';

class PaxPlayer {
  Future<String?> getCardNumber() {
    return PaxPlayerPlatform.instance.getCardNumber();
  }

  Future<String?> getDeviceInfo() {
    return PaxPlayerPlatform.instance.getDeviceInfo();
  }

  Future<bool?> getBeep(int time) {
    return PaxPlayerPlatform.instance.getBeep(time);
  }

  Future<bool?> setEnableNavBar(bool state) {
    return PaxPlayerPlatform.instance.setEnableNavBar(state);
  }
}
