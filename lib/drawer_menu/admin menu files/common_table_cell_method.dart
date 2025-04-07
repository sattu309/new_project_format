import 'package:flutter/material.dart';
import 'package:volpes/resources/height_width.dart';

import '../../Resources/app_colors.dart';

Widget tableCell(String text, {bool isHeader = false, int? rowIndex, double? width}) {
  return
    Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      decoration: BoxDecoration(
        color: isHeader
            ? AppColors.primaryClr // Header = Primary Color
            : (rowIndex != null && rowIndex.isOdd ? Colors.grey[200]! : Colors.white),  // Header = Primary Color, Non-header = White
        border: Border.all(color: Colors.grey.shade50,width: 0.2),
      ),
      child: Text(
        text,
         maxLines: 1,
        style: TextStyle(
          fontSize: 9,
          fontWeight: isHeader ? FontWeight.w500 : FontWeight.w400,
          color: isHeader ? Colors.white : Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
}
Table todayTableData({
  required String itemName,
  required String retailValue,
  required String storeValue,
  required String ccValue,
  required String totalValue,
  int? index
}) {
  return Table(
    // border: TableBorder.all(),
    columnWidths: {
      0: FlexColumnWidth(2.5),
      1: FlexColumnWidth(2.6),
      2: FlexColumnWidth(2.2),
      3: FlexColumnWidth(1),
      4: FlexColumnWidth(2),
    },
    children: [
      TableRow(children: [
        tableCell(itemName, rowIndex: index),
        tableCell(retailValue, rowIndex: index),
        tableCell(storeValue, rowIndex: index),
        tableCell(ccValue, rowIndex: index),
        tableCell(formatter.format(double.tryParse(totalValue)), rowIndex: index),


      ]),

    ],
  );
}