
import 'disable_screenshots_platform_interface.dart';

class DisableScreenshots {
  Future<String?> getPlatformVersion() {
    return DisableScreenshotsPlatform.instance.getPlatformVersion();
  }

  Future<void> enableScreenshots() {
    return DisableScreenshotsPlatform.instance.enableScreenshots();
  }

  Future<void> disableScreenshots() {
    return DisableScreenshotsPlatform.instance.disableScreenshots();
  }

}
