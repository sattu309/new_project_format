import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volpes/resources/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryClr,
        child: Center(child: Text("VOLPES",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontFamily: "serif",color: Colors.white,fontSize: 40))),
      ),
    );
  }
}
