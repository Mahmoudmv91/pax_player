import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pax_player_method_channel.dart';

abstract class PaxPlayerPlatform extends PlatformInterface {
  /// Constructs a PaxPlayerPlatform.
  PaxPlayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static PaxPlayerPlatform _instance = MethodChannelPaxPlayer();

  /// The default instance of [PaxPlayerPlatform] to use.
  ///
  /// Defaults to [MethodChannelPaxPlayer].
  static PaxPlayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PaxPlayerPlatform] when
  /// they register themselves.
  static set instance(PaxPlayerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getCardNumber() {
    throw UnimplementedError('getCardNumber has not been implemented.');
  }

  Future<String?> getDeviceInfo() {
    throw UnimplementedError('getDeviceInfo has not been implemented.');
  }

  Future<bool?> getBeep(int time) {
    throw UnimplementedError('getBeep has not been implemented.');
  }

  Future<bool?> setEnableNavBar(bool state) {
    throw UnimplementedError('setEnableNavBar has not been implemented.');
  }
}
