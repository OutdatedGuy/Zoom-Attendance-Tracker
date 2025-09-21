// Dart Packages
import 'dart:io';

// Flutter Packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:window_size/window_size.dart';

// Pages
import 'package:attendance_tracker/pages/HomePage/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    setWindowMinSize(const Size(400, 900));
    // Open the app in the center of the screen
    await getCurrentScreen().then((screen) {
      setWindowFrame(
        Rect.fromCenter(
          center: Offset(
            (screen?.visibleFrame.width ?? 1920) / 2,
            (screen?.visibleFrame.height ?? 1080) / 2,
          ),
          width: 1080,
          height: 900,
        ),
      );
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Tracker',
      theme: _getThemeData(),
      darkTheme: _getThemeData(brightness: Brightness.dark),
      home: const HomePage(),
    );
  }

  ThemeData _getThemeData({Brightness brightness = Brightness.light}) {
    return ThemeData(
      brightness: brightness,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
