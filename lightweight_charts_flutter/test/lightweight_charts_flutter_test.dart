import 'package:flutter_test/flutter_test.dart';
import 'package:lightweight_charts_flutter/lightweight_charts_flutter.dart';
import 'package:lightweight_charts_flutter/lightweight_charts_flutter_platform_interface.dart';
import 'package:lightweight_charts_flutter/lightweight_charts_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLightweightChartsFlutterPlatform
    with MockPlatformInterfaceMixin
    implements LightweightChartsFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LightweightChartsFlutterPlatform initialPlatform = LightweightChartsFlutterPlatform.instance;

  test('$MethodChannelLightweightChartsFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLightweightChartsFlutter>());
  });

  test('getPlatformVersion', () async {
    LightweightChartsFlutter lightweightChartsFlutterPlugin = LightweightChartsFlutter();
    MockLightweightChartsFlutterPlatform fakePlatform = MockLightweightChartsFlutterPlatform();
    LightweightChartsFlutterPlatform.instance = fakePlatform;

    expect(await lightweightChartsFlutterPlugin.getPlatformVersion(), '42');
  });
}
