import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/splash/splash_screen.dart';

import 'app_common_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Volpes',
      theme: AppTheme.lightTheme(context),
      home: SplashScreen(),
    );
  }
}

