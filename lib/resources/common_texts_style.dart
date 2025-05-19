import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




const TextStyle appBarStyle = TextStyle(fontSize: 18,color: CupertinoColors.black,fontFamily: "calbin");
const TextStyle textHeading = TextStyle(fontSize: 10,color: CupertinoColors.systemGrey,fontWeight: FontWeight.w600,fontFamily: "calbin");
const TextStyle userText = TextStyle(fontSize: 13,color: Color(0xff000000),fontWeight: FontWeight.w600,fontFamily: "calbin");

showSnackBarView({required BuildContext context,required String msg, required Color bgColor}){
  SnackBar snackBar = SnackBar(
      content: Text(msg,style: userText.copyWith(color: Colors.white)),
      backgroundColor: bgColor,
      duration:  Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


class CustomTextField1 extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final Widget? suffix;
  final bool readOnly;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField1({
    Key? key,
    this.controller,
    this.hint,
    this.suffix,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 40,
      child: TextFormField(
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: "cabin", // Use custom font
          color: Colors.grey.shade500, // Text color
        ),
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 10,fontFamily: "cabin"),
          filled: true,
            fillColor:  Color(0xffF6F6F6).withOpacity(.10),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:  BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:  BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:  BorderSide(color: Colors.grey.shade400),
          ),
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
