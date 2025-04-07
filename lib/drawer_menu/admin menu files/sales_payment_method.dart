import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volpes/resources/custom_loader.dart';
import '../../Resources/app_colors.dart';
import '../../common_repository/common_api_method.dart';
import '../../models/sale_by_payMethod.dart';
import '../../resources/api_urls.dart';
import '../../resources/common_texts_style.dart';
import '../../resources/height_width.dart';
import 'common_appbar_drawer.dart';

class SalesPaymentMethod extends StatefulWidget {
  const SalesPaymentMethod({super.key});

  @override
  State<SalesPaymentMethod> createState() => _SalesPaymentMethodState();
}

class _SalesPaymentMethodState extends State<SalesPaymentMethod> {
  Repositories repositories = Repositories();
  SaleByPayMethodModel? saleByPayMethodModel;
  double todayAmountTotal = 0.0;
  double yesTerDayAmountTotal = 0.0;
  double dayBeforeYesterDayAmountTotal = 0.0;
  double twodayBeforeYesterDayAmountTotal = 0.0;
  double currentWeekAmountTotal = 0.0;
  double currentMonthAmountTotal = 0.0;

  int todayTotalOrders = 0;
  int yesTerDayTotalOrders = 0;
  int dayBeforeYesterDayTotalOrders = 0;
  int twodayBeforeYesterDayTotalOrders = 0;
  int currentWeekTotalOrders = 0;
  int currentMonthTotalOrders = 0;
  getSalePayMethodsData() {
    repositories.getApi(url: ApiUrls.salesPayMethodUrl).then((value) {
      saleByPayMethodModel = SaleByPayMethodModel.fromJson(jsonDecode(value));

      setState(() {
        // today order total
        todayTotalOrders = ((saleByPayMethodModel!.success!.paymethodRep!.tODAY!.dIRECT!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.tODAY!.pAYFAST!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.tODAY!.pAYU!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.tODAY!.pAYJUSTNOW!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.tODAY!.tFG!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.tODAY!.oZOW!.orders ?? 0.0).toInt());
        // yesterday order total
        yesTerDayTotalOrders = ((saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.dIRECT!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.pAYFAST!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.pAYU!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.pAYJUSTNOW!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.tFG!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.oZOW!.orders ?? 0.0).toInt());
        // day before yesterday order total
        dayBeforeYesterDayTotalOrders = ((saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.dIRECT!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.pAYFAST!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.pAYU!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.pAYJUSTNOW!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.tFG!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.oZOW!.orders ?? 0.0).toInt());
      // 2 day before yesterday order total
        twodayBeforeYesterDayTotalOrders = ((saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.dIRECT!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.pAYFAST!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.pAYU!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.pAYJUSTNOW!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.tFG!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.oZOW!.orders ?? 0.0).toInt());
      //  current week order total
        currentWeekTotalOrders = ((saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.dIRECT!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.pAYFAST!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.pAYU!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.pAYJUSTNOW!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.tFG!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.oZOW!.orders ?? 0.0).toInt());
    //  current month order total
        currentMonthTotalOrders = ((saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.dIRECT!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.pAYFAST!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.pAYU!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.pAYJUSTNOW!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.tFG!.orders ?? 0.0).toInt())+
            ((saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.oZOW!.orders ?? 0.0).toInt());



        // today amount total
        todayAmountTotal = (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.dIRECT!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.pAYFAST!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.pAYU!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.pAYJUSTNOW!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.tFG!.amount.toString())! / 1.15)+
            (double.parse(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.oZOW!.amount.toString()) / 1.15);
      // yesterday amount total
        yesTerDayAmountTotal = (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.dIRECT!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.pAYFAST!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.pAYU!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.pAYJUSTNOW!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.tFG!.amount.toString())! / 1.15)+
            (double.parse(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.oZOW!.amount.toString()) / 1.15);
    // day before yesterday amount total
        dayBeforeYesterDayAmountTotal = (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.dIRECT!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.pAYFAST!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.pAYU!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.pAYJUSTNOW!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.tFG!.amount.toString())! / 1.15)+
            (double.parse(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.oZOW!.amount.toString()) / 1.15);
    // 2 day before yesterday amount total
        twodayBeforeYesterDayAmountTotal = (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.dIRECT!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.pAYFAST!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.pAYU!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.pAYJUSTNOW!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.tFG!.amount.toString())! / 1.15)+
            (double.parse(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.oZOW!.amount.toString()) / 1.15);
        // current week amount total
          currentWeekAmountTotal = (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.dIRECT!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.pAYFAST!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.pAYU!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.pAYJUSTNOW!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.tFG!.amount.toString())! / 1.15)+
            (double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.oZOW!.amount.toString()) / 1.15);
        // current month amount total
        currentMonthAmountTotal = (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.dIRECT!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.pAYFAST!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.pAYU!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.pAYJUSTNOW!.amount.toString())! / 1.15)+
            (double.tryParse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.tFG!.amount.toString())! / 1.15)+
            (double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.oZOW!.amount.toString()) / 1.15);

      });
    });
  }
  @override
  void initState() {
    super.initState();
    getSalePayMethodsData();

  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: customerAppBar(context, "Sales By Payment Method"),
      body:
          saleByPayMethodModel != null ?
      Padding(
        padding:  EdgeInsets.only(left: 15,right: 15,top: 7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("TODAY",style: textHeading.copyWith(color: Colors.black),),
              giveHeight(3),
              todayTableData(),
              giveHeight(10),
              Text("YESTERDAY",style: textHeading.copyWith(color: Colors.black),),
              giveHeight(3),
              yesTerDayTableData(),
              giveHeight(10),
              Text("DAY BEFORE YESTERDAY",style: textHeading.copyWith(color: Colors.black),),
              giveHeight(3),
              dayBeforeYesterDayTableData(),
              giveHeight(10),
              Text("2 DAYS BEFORE YESTERDAY",style: textHeading.copyWith(color: Colors.black),),
              giveHeight(3),
              twoDaysBeforeYesterDayTableData(),
              giveHeight(10),
              Text("CURRENT WEEK",style: textHeading.copyWith(color: Colors.black),),
              giveHeight(3),
              currentWeekTableData(),
              giveHeight(10),
              Text("CURRENT MONTH",style: textHeading.copyWith(color: Colors.black),),
              giveHeight(3),
              currentMonthTableData(),
              giveHeight(10),
            ],
          ),
        ),
      ):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25)),
    );
  }
  Table todayTableData() {
    return Table(
      // border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(3), // First column width
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
      },
      children: [
        TableRow(children: [
          tableCell("SALES", isHeader: true,),
          tableCell("ORDER", isHeader: true),
          tableCell("AMOUNT", isHeader: true),
        ]),
        TableRow(children: [
          tableCell("PAYU",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.pAYU!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.pAYU!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("OZOW",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.oZOW!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.oZOW!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("PAYJUSTNOW",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.pAYJUSTNOW!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.pAYJUSTNOW!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("TFG",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.tFG!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.tFG!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("DIRECT",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.dIRECT!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.dIRECT!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("PAYFAST",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.pAYFAST!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.tODAY!.pAYFAST!.amount.toString())),
          )]),

        TableRow(
            children: [
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  "Total",
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  todayTotalOrders.toString(),
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  formatter.format(double.parse(todayAmountTotal.toString()) / 1.15),
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
            ]
        )
      ],
    );
  }
  Table yesTerDayTableData() {
    return Table(
      // border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(3), // First column width
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
      },
      children: [
        TableRow(children: [
          tableCell("SALES", isHeader: true,),
          tableCell("ORDER", isHeader: true),
          tableCell("AMOUNT", isHeader: true),
        ]),
        TableRow(children: [
          tableCell("PAYU",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.pAYU!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.pAYU!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("OZOW",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.oZOW!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.oZOW!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("PAYJUSTNOW",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.pAYJUSTNOW!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.pAYJUSTNOW!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("TFG",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.tFG!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.tFG!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("DIRECT",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.dIRECT!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.dIRECT!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("PAYFAST",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.pAYFAST!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.yESTERDAY!.pAYFAST!.amount.toString())),
          )]),

        TableRow(
            children: [
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  "Total",
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  yesTerDayTotalOrders.toString(),
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  formatter.format(double.parse(yesTerDayAmountTotal.toString()) / 1.15),
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
            ]
        )
      ],
    );
  }
  Table dayBeforeYesterDayTableData() {
    return Table(
      // border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(3), // First column width
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
      },
      children: [
        TableRow(children: [
          tableCell("SALES", isHeader: true,),
          tableCell("ORDER", isHeader: true),
          tableCell("AMOUNT", isHeader: true),
        ]),
        TableRow(children: [
          tableCell("PAYU",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.pAYU!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.pAYU!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("OZOW",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.oZOW!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.oZOW!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("PAYJUSTNOW",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.pAYJUSTNOW!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.pAYJUSTNOW!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("TFG",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.tFG!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.tFG!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("DIRECT",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.dIRECT!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.dIRECT!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("PAYFAST",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.pAYFAST!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.dAYBEFOREYESTERDAY!.pAYFAST!.amount.toString())),
          )]),

        TableRow(
            children: [
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  "Total",
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  dayBeforeYesterDayTotalOrders.toString(),
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  formatter.format(double.parse(dayBeforeYesterDayAmountTotal.toString()) / 1.15),
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
            ]
        )
      ],
    );
  }
  Table twoDaysBeforeYesterDayTableData() {
    return Table(
      // border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(3), // First column width
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
      },
      children: [
        TableRow(children: [
          tableCell("SALES", isHeader: true,),
          tableCell("ORDER", isHeader: true),
          tableCell("AMOUNT", isHeader: true),
        ]),
        TableRow(children: [
          tableCell("PAYU",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.pAYU!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.pAYU!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("OZOW",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.oZOW!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.oZOW!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("PAYJUSTNOW",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.pAYJUSTNOW!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.pAYJUSTNOW!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("TFG",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.tFG!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.tFG!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("DIRECT",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.dIRECT!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.dIRECT!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("PAYFAST",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.pAYFAST!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.t2DAYSBEFOREYESTERDAY!.pAYFAST!.amount.toString())),
          )]),

        TableRow(
            children: [
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  "Total",
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  twodayBeforeYesterDayTotalOrders.toString(),
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  formatter.format(double.parse(twodayBeforeYesterDayAmountTotal.toString()) / 1.15),
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
            ]
        )
      ],
    );
  }
  Table currentWeekTableData() {
    return Table(
      // border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(3), // First column width
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
      },
      children: [
        TableRow(children: [
          tableCell("SALES", isHeader: true,),
          tableCell("ORDER", isHeader: true),
          tableCell("AMOUNT", isHeader: true),
        ]),
        TableRow(children: [
          tableCell("PAYU",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.pAYU!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.pAYU!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("OZOW",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.oZOW!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.oZOW!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("PAYJUSTNOW",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.pAYJUSTNOW!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.pAYJUSTNOW!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("TFG",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.tFG!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.tFG!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("DIRECT",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.dIRECT!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.dIRECT!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("PAYFAST",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.pAYFAST!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTWEEK!.pAYFAST!.amount.toString())),
          )]),

        TableRow(
            children: [
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  "Total",
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  currentWeekTotalOrders.toString(),
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  formatter.format(double.parse(currentWeekAmountTotal.toString()) / 1.15),
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
            ]
        )
      ],
    );
  }
  Table currentMonthTableData() {
    return Table(
      // border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(3), // First column width
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
      },
      children: [
        TableRow(children: [
          tableCell("SALES", isHeader: true,),
          tableCell("ORDER", isHeader: true),
          tableCell("AMOUNT", isHeader: true),
        ]),
        TableRow(children: [
          tableCell("PAYU",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.pAYU!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.pAYU!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("OZOW",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.oZOW!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.oZOW!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("PAYJUSTNOW",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.pAYJUSTNOW!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.pAYJUSTNOW!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("TFG",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.tFG!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.tFG!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("DIRECT",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.dIRECT!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.dIRECT!.amount.toString())),
          )]),
        TableRow(children: [
          tableCell("PAYFAST",),
          tableCell(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.pAYFAST!.orders.toString()),
          tableCell(formatter.format(double.parse(saleByPayMethodModel!.success!.paymethodRep!.cURRENTMONTH!.pAYFAST!.amount.toString())),
          )]),

        TableRow(
            children: [
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  "Total",
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  currentMonthTotalOrders.toString(),
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
              TableCell(child: Container(child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Header = Primary Color, Non-header = White
                  border: Border.all(color: Colors.grey.shade100,width: 0.5),

                ),
                child: Text(
                  formatter.format(double.parse(currentMonthAmountTotal.toString()) / 1.15),
                  style: userText.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ))),
            ]
        )
      ],
    );
  }
  Widget tableCell(String text, {bool isHeader = false}) {
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        decoration: BoxDecoration(
          color: isHeader ? AppColors.primaryClr : Colors.white, // Header = Primary Color, Non-header = White
          border: Border.all(color: Colors.grey.shade100,width: 0.5),

        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 9,
            fontWeight: isHeader ? FontWeight.w500 : FontWeight.normal,
            color: isHeader ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      );
  }
}
