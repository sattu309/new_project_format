import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/push_notification/notification_service.dart';
import 'package:volpes/splash/splash_screen.dart';

import 'app_common_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService().initializeNotification();
  NotificationService().createNotificationChannel();
  NotificationService.initializeFirebaseMessaging();
  getFcm();
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

Future<void> getFcm() async {
  final fcm = await FirebaseMessaging.instance.getToken();
  print("FCM TOKKEN: ${fcm.toString()}");
}