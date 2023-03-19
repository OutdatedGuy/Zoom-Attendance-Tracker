// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:flutter_native_splash/flutter_native_splash.dart';

// Pages
import 'package:attendance_tracker/pages/HomePage/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
    FlutterNativeSplash.remove();
  });

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
