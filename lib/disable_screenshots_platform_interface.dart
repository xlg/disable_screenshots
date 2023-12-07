import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'disable_screenshots_method_channel.dart';

abstract class DisableScreenshotsPlatform extends PlatformInterface {
  /// Constructs a DisableScreenshotsPlatform.
  DisableScreenshotsPlatform() : super(token: _token);

  static final Object _token = Object();

  static DisableScreenshotsPlatform _instance = MethodChannelDisableScreenshots();

  /// The default instance of [DisableScreenshotsPlatform] to use.
  ///
  /// Defaults to [MethodChannelDisableScreenshots].
  static DisableScreenshotsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DisableScreenshotsPlatform] when
  /// they register themselves.
  static set instance(DisableScreenshotsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> disableScreenshots() {
    throw UnimplementedError('disableScreenshots() has not been implemented.');
  }

  Future<void> enableScreenshots() {
    throw UnimplementedError('enableScreenshots() has not been implemented.');
  }
}
