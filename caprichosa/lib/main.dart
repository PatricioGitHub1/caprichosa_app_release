import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_desktop_kit/cdk_app.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'app_data.dart';
import 'main_widget.dart'; // Import your MainWidget

void main() async {
  // For Linux, macOS and Windows, initialize WindowManager
  try {
    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      WidgetsFlutterBinding.ensureInitialized();
      await WindowManager.instance.ensureInitialized();
      windowManager.waitUntilReadyToShow().then(showWindow);
    }
  } catch (e) {
    print(e);
  }

  AppData appData = AppData();

  runApp(
    // Wrap your MyApp with Provider
    ChangeNotifierProvider(
      create: (context) => appData,
      child: const CDKApp(
        defaultAppearance: "system", // system, light, dark
        defaultColor:
            "systemBlue", // systemBlue, systemPurple, systemPink, systemRed, systemOrange, systemYellow, systemGreen, systemGray
        child: MainWidget(title: '',),
  )));
}

void showWindow(_) async {
  const size = Size(1200.0, 800.0);
  windowManager.setSize(size);
  windowManager.setMinimumSize(size);
  await windowManager.setTitle('Kouun');
}

