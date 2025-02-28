import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volpes/Resources/app_colors.dart';


class CustomTextField extends StatelessWidget {
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Color? bgColor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hint;
  final Iterable<String>? autofillHints;
  final TextEditingController? controller;
  final bool? readOnly;
  final int? value = 0;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;
  final VoidCallback? onTap;
  final length;

  const CustomTextField({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.bgColor,
    this.validator,
    this.suffix,
    this.autofillHints,
    this.prefix,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.length,
    this.floatingLabelBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 13,color: Colors.black54.withOpacity(0.6)),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: onTap,
      readOnly: readOnly!,
      controller: controller,
      obscureText: hint == hint ? obscureText! : false,
      autofillHints: autofillHints,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines,
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
      ],
      decoration: InputDecoration(

          hintText: hint,
          focusColor: AppColors.primaryClr,
          hintStyle:
          TextStyle(color: Colors.black54.withOpacity(0.6), fontSize: 13),
          filled: true,
          fillColor:  Color(0xffF6F6F6).withOpacity(.10),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.grey.shade300,),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          border: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.grey.shade300, width: 3.0),
              borderRadius: BorderRadius.circular(8)),
          suffixIcon: suffix,
          prefixIcon: prefix),
    );
  }
}
