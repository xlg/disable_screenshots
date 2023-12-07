import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'disable_screenshots_platform_interface.dart';

/// An implementation of [DisableScreenshotsPlatform] that uses method channels.
class MethodChannelDisableScreenshots extends DisableScreenshotsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('disable_screenshots');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<void> disableScreenshots() async {
    await methodChannel.invokeMethod('disableScreenshots');
  }

  Future<void> enableScreenshots() async {
    await methodChannel.invokeMethod('enableScreenshots');
  }
}
