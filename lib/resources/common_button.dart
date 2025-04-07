import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/resources/height_width.dart';

class CommonAppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isArrow;

  const CommonAppButton({Key? key, required this.title, required this.onPressed,  required this.isArrow,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontFamily: "cabin",
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: .2,
                        fontSize: 14)),
                giveWidth(5),
                isArrow ?  ImageIcon((AssetImage("assets/images/arrow.png")),size: 17,) : SizedBox()
              ],
            )),
      );
  }
}
