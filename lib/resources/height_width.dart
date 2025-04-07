import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

giveHeight(double size){
  return SizedBox(height: size,);
}

giveWidth(double size){
  return SizedBox(width: size,);
}

final formatter = NumberFormat.currency(locale: 'en_ZA', symbol: 'R', decimalDigits: 2);
