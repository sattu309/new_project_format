import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';

class CommonAppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CommonAppButton({Key? key, required this.title, required this.onPressed,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.primaryClr
        ),
        child:
        ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              // minimumSize: 79,
              backgroundColor: AppColors.primaryClr,
              // backgroundColor: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // <-- Radius
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontFamily: "serif",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: .2,
                        fontSize: 15)),
                Icon(Icons.arrow_right_outlined)
              ],
            )),
      );
  }
}
