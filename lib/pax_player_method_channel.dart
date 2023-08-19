import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pax_player_platform_interface.dart';

/// An implementation of [PaxPlayerPlatform] that uses method channels.
class MethodChannelPaxPlayer extends PaxPlayerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pax.plugin.pki.parhamkish.vakili.pax_player/pax_reader');

  @override
  Future<String?> getCardNumber() async {
    final cardNumber = await methodChannel.invokeMethod<String>('getCardNumber');
    return cardNumber;
  }
  @override
  Future<bool?> getBeep(int time) async{
    final callBeep = await methodChannel.invokeMethod<bool>('getBeep',{"time":time});
    return callBeep;
  }

  @override
  Future<String?> getDeviceInfo() async{
    final deviceInfo = await methodChannel.invokeMethod<String>('getDeviceInfo');
    return deviceInfo;
  }


  @override
  Future<bool?> setEnableNavBar(bool state) async{
    final setEnableNavBar = await methodChannel.invokeMethod<bool>('setEnableNavBar',{"state":state});
    return setEnableNavBar;
  }
  @override
  Future<bool?> initPrinter() async {
    final initPrinter = await methodChannel.invokeMethod<bool>('init');
    return initPrinter;
  }
  @override
  Future<String?> getStatusPrinter() async {
    final getStatusPrinter = await methodChannel.invokeMethod<String>('getStatus');
    return getStatusPrinter;
  }
  @override
  Future<String?> printReceipt() async {
    final printReceipt = await methodChannel.invokeMethod<String>('printReceipt');
    return printReceipt;
  }
  @override
  Future<String?> printReceiptWithQr() async {
    final printReceiptWithQr = await methodChannel.invokeMethod<String>('printReceiptWithQr');
    return printReceiptWithQr;
  }
  @override
  Future<bool?> printBitmap(Uint8List bitmap) async {
    final printBitmap = await methodChannel.invokeMethod<bool>('printBitmap',{"bitmap":bitmap});
    return printBitmap;
  }
}
