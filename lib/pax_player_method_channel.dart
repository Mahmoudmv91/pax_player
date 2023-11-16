import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pax_player_platform_interface.dart';

/// An implementation of [PaxPlayerPlatform] that uses method channels.
class MethodChannelPaxPlayer extends PaxPlayerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(
      'pax.plugin.pki.parhamkish.vakili.pax_player/pax_reader');

  @override
  Future<String?> getCardNumber() async {
    // Invoke the native method 'getCardNumber' and return the result.
    final cardNumber =
        await methodChannel.invokeMethod<String>('getCardNumber');
    return cardNumber;
  }

  @override
  Future<String?> getScanBarcode() async {
    // Invoke the native method 'getBarcode' and return the result.
    final cardNumber = await methodChannel.invokeMethod<String>('getBarcode');
    return cardNumber;
  }

  @override
  Future<bool?> getBeep(int time) async {
    // Invoke the native method 'getBeep' with the specified 'time' parameter and return the result.
    final callBeep =
        await methodChannel.invokeMethod<bool>('getBeep', {"time": time});
    return callBeep;
  }

  @override
  Future<String?> getDeviceInfo() async {
    // Invoke the native method 'getDeviceInfo' and return the result.
    final deviceInfo =
        await methodChannel.invokeMethod<String>('getDeviceInfo');
    return deviceInfo;
  }

  @override
  Future<bool?> setEnableNavBar(bool state) async {
    // Invoke the native method 'setEnableNavBar' with the specified 'state' parameter and return the result.
    final setEnableNavBar = await methodChannel
        .invokeMethod<bool>('setEnableNavBar', {"state": state});
    return setEnableNavBar;
  }

  @override
  Future<bool?> initPrinter() async {
    // Invoke the native method 'init' and return the result.
    final initPrinter = await methodChannel.invokeMethod<bool>('init');
    return initPrinter;
  }

  @override
  Future<String?> getStatusPrinter() async {
    // Invoke the native method 'getStatus' and return the result.
    final getStatusPrinter =
        await methodChannel.invokeMethod<String>('getStatus');
    return getStatusPrinter;
  }

  @override
  Future<String?> printReceipt() async {
    // Invoke the native method 'printReceipt' and return the result.
    final printReceipt =
        await methodChannel.invokeMethod<String>('printReceipt');
    return printReceipt;
  }

  @override
  Future<String?> printReceiptWithQr() async {
    // Invoke the native method 'printReceiptWithQr' and return the result.
    final printReceiptWithQr =
        await methodChannel.invokeMethod<String>('printReceiptWithQr');
    return printReceiptWithQr;
  }

  @override
  Future<bool?> printBitmap(Uint8List bitmap) async {
    // Invoke the native method 'printBitmap' with the specified 'bitmap' parameter and return the result.
    final printBitmap = await methodChannel
        .invokeMethod<bool>('printBitmap', {"bitmap": bitmap});
    return printBitmap;
  }

  @override
  Future<bool?> printNormal() async {
    // Invoke the native method 'printNormal' and return the result.
    final printNormal = await methodChannel.invokeMethod<bool>('printNormal');
    return printNormal;
  }

  @override
  Future<String?> start() async {
    // Invoke the native method 'start' and return the result.
    final start = await methodChannel.invokeMethod<String>('start');
    return start;
  }

  @override
  Future<bool?> setGray(int level) async {
    // Invoke the native method 'setGray' with the specified 'level' parameter and return the result.
    final start =
        await methodChannel.invokeMethod<bool>('setGray', {"level": level});
    return start;
  }
}
