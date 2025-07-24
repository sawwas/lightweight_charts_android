import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lightweight_charts_flutter_platform_interface.dart';

/// An implementation of [LightweightChartsFlutterPlatform] that uses method channels.
class MethodChannelLightweightChartsFlutter extends LightweightChartsFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lightweight_charts_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
