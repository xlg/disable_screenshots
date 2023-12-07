import 'package:flutter_test/flutter_test.dart';
import 'package:disable_screenshots/disable_screenshots.dart';
import 'package:disable_screenshots/disable_screenshots_platform_interface.dart';
import 'package:disable_screenshots/disable_screenshots_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDisableScreenshotsPlatform
    with MockPlatformInterfaceMixin
    implements DisableScreenshotsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DisableScreenshotsPlatform initialPlatform = DisableScreenshotsPlatform.instance;

  test('$MethodChannelDisableScreenshots is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDisableScreenshots>());
  });

  test('getPlatformVersion', () async {
    DisableScreenshots disableScreenshotsPlugin = DisableScreenshots();
    MockDisableScreenshotsPlatform fakePlatform = MockDisableScreenshotsPlatform();
    DisableScreenshotsPlatform.instance = fakePlatform;

    expect(await disableScreenshotsPlugin.getPlatformVersion(), '42');
  });
}
