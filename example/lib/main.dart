import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:disable_screenshots/disable_screenshots.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _disableScreenshotsPlugin = DisableScreenshots();

  bool _enableScreenshots = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _disableScreenshotsPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Running on: $_platformVersion\n'),
                Row(
                  mainAxisSize: MainAxisSize.min,
                      children: [

                        Text(_enableScreenshots?"当前可以截图":"当前不可以截图",style: TextStyle(color: Colors.red,fontSize: 14)),
                        Checkbox(value: _enableScreenshots, onChanged: (b){
                          if (b==true) {
                            _enableScreenshots = true;
                            _disableScreenshotsPlugin.disableScreenshots();
                          } else {
                            _enableScreenshots = false;
                            _disableScreenshotsPlugin.enableScreenshots();
                          }
                          setState(() {

                          });
                        }),
                      ],
                    )

              ],
            ),
      ),
    );
  }
}
