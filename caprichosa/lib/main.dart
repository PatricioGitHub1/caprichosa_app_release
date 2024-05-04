import 'dart:io';
import 'package:flutter/cupertino.dart';
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
      child: const MyApp(
        defaultAppearance: "light", // system, light, dark
        defaultColor:
            "systemBlue", // systemBlue, systemPurple, systemPink, systemRed, systemOrange, systemYellow, systemGreen, systemGray
      ),
  ));
}

void showWindow(_) async {
  const size = Size(1200.0, 800.0);
  windowManager.setSize(size);
  windowManager.setMinimumSize(size);
  await windowManager.setTitle('Caprichosa');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required String defaultAppearance, required String defaultColor});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: MainWidget(title: '',),
    );

  }
}
