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

void main() {
  WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
    FlutterNativeSplash.remove();
  });

  if (!kIsWeb) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowMinSize(const Size(400, 800));
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Tracker',
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
