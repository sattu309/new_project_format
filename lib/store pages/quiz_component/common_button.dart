import 'package:flutter/material.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/height_width.dart';

ElevatedButton buttonCommon({required String title,required VoidCallback onTapp}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryClr),
      onPressed: onTapp, child: Text(title,style: TextStyle(letterSpacing: 1,fontWeight: FontWeight.w400),));
}
SizedBox buttonCommon1({required String title,required VoidCallback onTapp, required BuildContext context}){
  var width = MediaQuery.of(context).size.width;
  return SizedBox(
    width: width*.55,
    height: 42,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor:AppColors.primaryClr),
        onPressed: onTapp, child: Text(title,style: TextStyle(letterSpacing: 1,fontWeight: FontWeight.w500),)),
  );
}

SizedBox startQuiz({required BuildContext context,required String title,required VoidCallback onTapp, bool? isArrow}){
  var width = MediaQuery.of(context).size.width;
  return
    SizedBox(
    width: width*.55,
    height: 45,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryClr),
        onPressed: onTapp, child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,style: TextStyle(letterSpacing: 1,fontWeight: FontWeight.w400),),
             giveWidth(5),
              ImageIcon(AssetImage("assets/images/arrow.png"),size: 17,)
          ],
        )),
  );
}