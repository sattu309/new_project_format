import 'package:flutter/material.dart';

import 'Resources/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: false,
      fontFamily: "system-ui;",
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.red),
          titleTextStyle: TextStyle(color: Colors.black)),
      textTheme: TextTheme(
        bodyLarge: const TextStyle(color: Colors.black,fontSize: 18),
        bodyMedium: const TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),
        bodySmall:  TextStyle(color: Colors.grey.shade600,fontSize: 12),
        titleSmall: TextStyle(color: AppColors.primaryClr,fontSize: 13,fontWeight: FontWeight.w500),
        titleMedium:  TextStyle(color: Color(0xff0000000),fontSize: 17,fontWeight: FontWeight.w500),
        headlineMedium: const TextStyle(color: Colors.black),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     elevation: 0,
      //     backgroundColor: Colors.black,
      //     foregroundColor: Colors.white,
      //     minimumSize: const Size(double.infinity, 48),
      //     shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(16)),
      //     ),
      //   ),
      // ),
    );
  }
}

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(28)),
  borderSide: BorderSide(color: Colors.black),
  gapPadding: 10,
);
