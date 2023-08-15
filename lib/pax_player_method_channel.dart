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
}
