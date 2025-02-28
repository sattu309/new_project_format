import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




const TextStyle appBarStyle = TextStyle(fontSize: 18,color: CupertinoColors.black);
const TextStyle textHeading = TextStyle(fontSize: 10,color: CupertinoColors.systemGrey,fontWeight: FontWeight.w600);
const TextStyle userText = TextStyle(fontSize: 13,color: Color(0xff000000),fontWeight: FontWeight.w600);

showSnackBarView({required BuildContext context,required String msg, required Color bgColor}){
  SnackBar snackBar = SnackBar(
      content: Text(msg,style: TextStyle(color: Colors.red),),
      backgroundColor: bgColor,
      duration:  Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

