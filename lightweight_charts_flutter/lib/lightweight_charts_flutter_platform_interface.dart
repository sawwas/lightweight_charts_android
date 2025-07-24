import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lightweight_charts_flutter_method_channel.dart';

abstract class LightweightChartsFlutterPlatform extends PlatformInterface {
  /// Constructs a LightweightChartsFlutterPlatform.
  LightweightChartsFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static LightweightChartsFlutterPlatform _instance = MethodChannelLightweightChartsFlutter();

  /// The default instance of [LightweightChartsFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelLightweightChartsFlutter].
  static LightweightChartsFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LightweightChartsFlutterPlatform] when
  /// they register themselves.
  static set instance(LightweightChartsFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
