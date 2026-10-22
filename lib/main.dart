import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const SmritiRakshakApp());
}

class SmritiRakshakApp extends StatelessWidget {
  const SmritiRakshakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smriti Rakshak',

      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),

      home: const SplashScreen(),
    );
  }
}