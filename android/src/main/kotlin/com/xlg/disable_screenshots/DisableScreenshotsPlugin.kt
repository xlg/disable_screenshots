package com.xlg.disable_screenshots

import android.app.Activity
import android.app.Application
import android.os.Bundle
import android.util.Log
import android.view.WindowManager

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** DisableScreenshotsPlugin */
class DisableScreenshotsPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "disable_screenshots")
    channel.setMethodCallHandler(this)
    (flutterPluginBinding.applicationContext as Application).registerActivityLifecycleCallbacks(object : Application.ActivityLifecycleCallbacks {
      override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {
      }

      override fun onActivityStarted(activity: Activity) {

      }

      override fun onActivityResumed(activity: Activity) {
        this@DisableScreenshotsPlugin.activity = activity
      }

      override fun onActivityPaused(activity: Activity) {
      }

      override fun onActivityStopped(activity: Activity) {
      }

      override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {
      }

      override fun onActivityDestroyed(activity: Activity) {
        this@DisableScreenshotsPlugin.activity = null
      }

    })
  }



  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "disableScreenshots" -> {
        activity?.window?.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
        result.success(true)
      }

      "enableScreenshots" -> {
        activity?.window?.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
        activity?.window?.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)
        result.success(true)
      }

      else -> {
        result.notImplemented()
      }

    }
  }
  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


}
