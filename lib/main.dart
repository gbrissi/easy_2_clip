import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easy_2_clip/app.dart';
import 'package:ffmpeg_helper/helpers/ffmpeg_helper_class.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

Future<void> main() async {
  await FFMpegHelper.instance.initialize(); // This is a singleton instance
  WidgetsFlutterBinding.ensureInitialized();
  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();

  runApp(
    const App(),
  );

  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    const minSize = Size(960, 540);
    appWindow.minSize = minSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
