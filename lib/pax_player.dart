import 'dart:typed_data';

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
class PaxPrinter{
  Future<bool?> initPrinter() {
    return PaxPlayerPlatform.instance.initPrinter();
  }
  Future<String?> getStatusPrinter() {
    return PaxPlayerPlatform.instance.getStatusPrinter();
  }
  Future<String?> printReceipt() {
    return PaxPlayerPlatform.instance.printReceipt();
  }
  Future<String?> printReceiptWithQr() {
    return PaxPlayerPlatform.instance.printReceiptWithQr();
  }
  Future<bool?> printBitmap(Uint8List bitmap) {
    return PaxPlayerPlatform.instance.printBitmap(bitmap);
  }
  Future<bool?> printNormal() {
    return PaxPlayerPlatform.instance.printNormal();
  }
  Future<String?> start() {
    return PaxPlayerPlatform.instance.start();
  }
  Future<bool?> setGray(int level) {
    return PaxPlayerPlatform.instance.setGray(level);
  }
}
