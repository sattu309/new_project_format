import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:volpes/common_repository/common_api_method.dart';
import 'package:volpes/resources/api_urls.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';
import '../../Resources/app_colors.dart';
import '../../models/sales_overview_model.dart';
import 'common_appbar_drawer.dart';

class SalesOverviewPage extends StatefulWidget {
  const SalesOverviewPage({super.key});

  @override
  State<SalesOverviewPage> createState() => _SalesOverviewPageState();
}

class _SalesOverviewPageState extends State<SalesOverviewPage> {
  Repositories repositories = Repositories();
  SalesOverViewModel? salesOverViewModel;
  int todayCntTotal = 0;
  int yesterDayCntTotal = 0;
  int dayBeforeYesTerDayCntTotal = 0;
  int twoDaysBeforeYesTerDayCntTotal = 0;
  int currentWeekCntTotal = 0;
  int currentMonthCntTotal = 0;

  double todayAmountTotal = 0.0;
  double yesterDayAmountTotal = 0.0;
  double dayBeforeYesTerDayAmountTotal = 0.0;
  double twoDaysBeforeYesTerDayAmountTotal = 0.0;
  double currentWeekAmountTotal = 0.0;
  double currentMonthAmountTotal = 0.0;
  getSalesOverViewData() {
    repositories.getApi(url: ApiUrls.salesOrvView).then((value) {
      salesOverViewModel = SalesOverViewModel.fromJson(jsonDecode(value));

      setState(() {
        // today cnt total
        todayCntTotal = (salesOverViewModel!.success!.todayretailorder!.cnt ?? 0) +
            (salesOverViewModel!.success!.todaystoreorder!.cnt ?? 0) +
            (salesOverViewModel!.success!.todaycollectstoreorder!.cnt ?? 0);
        // yesterday cnt total
        yesterDayCntTotal = (salesOverViewModel!.success!.yesterdayretailorder!.cnt ?? 0) +
            (salesOverViewModel!.success!.yesterdaystoreorder!.cnt ?? 0) +
            (salesOverViewModel!.success!.yesterdaycollectstoreorder!.cnt ?? 0);
      // day before yesterday cnt total
        dayBeforeYesTerDayCntTotal = (salesOverViewModel!.success!.dbyesterdayretailorder!.cnt ?? 0) +
            (salesOverViewModel!.success!.dbyesterdaystoreorder!.cnt ?? 0) +
            (salesOverViewModel!.success!.dbyesterdaycollectstoreorder!.cnt ?? 0);

        // 2 days before yesterday cnt total
        twoDaysBeforeYesTerDayCntTotal = (salesOverViewModel!.success!.db2yesterdayretailorder!.cnt ?? 0) +
            (salesOverViewModel!.success!.db2yesterdaystoreorder!.cnt ?? 0) +
            (salesOverViewModel!.success!.db2yesterdaycollectstoreorder!.cnt ?? 0);

        // current week cnt total
        currentWeekCntTotal = (salesOverViewModel!.success!.day7retailorder!.cnt ?? 0) +
            (salesOverViewModel!.success!.day7storeorder!.cnt ?? 0) +
            (salesOverViewModel!.success!.day7collectstoreorder!.cnt ?? 0);

        // current month cnt total
        currentMonthCntTotal = (salesOverViewModel!.success!.day30retailorder!.cnt ?? 0) +
            (salesOverViewModel!.success!.day30storeorder!.cnt ?? 0) +
            (salesOverViewModel!.success!.day30collectstoreorder!.cnt ?? 0);


        // today amount total
        todayAmountTotal = (double.tryParse(salesOverViewModel!.success!.todayretailorder!.sumsubtotal) ?? 0.0) +
            (double.tryParse(salesOverViewModel!.success!.todaystoreorder!.sumsubtotal ?? "0.0") ?? 0.0) +
            (double.tryParse(salesOverViewModel!.success!.todaycollectstoreorder!.sumsubtotal) ?? 0.0);

        // day before yesterday amount total
        dayBeforeYesTerDayAmountTotal = (double.tryParse(salesOverViewModel!.success!.dbyesterdaystoreorder!.sumsubtotal) ?? 0.0) +
            (double.tryParse(salesOverViewModel!.success!.dbyesterdaystoreorder!.sumsubtotal ?? "0.0") ?? 0.0) +
            (double.tryParse(salesOverViewModel!.success!.dbyesterdaycollectstoreorder!.sumsubtotal) ?? 0.0);
      // yesterday amount total
        yesterDayAmountTotal = (double.tryParse(salesOverViewModel!.success!.yesterdayretailorder!.sumsubtotal) ?? 0.0) +
            (double.tryParse(salesOverViewModel!.success!.yesterdaystoreorder!.sumsubtotal ?? "0.0") ?? 0.0) +
            (double.tryParse(salesOverViewModel!.success!.yesterdaycollectstoreorder!.sumsubtotal) ?? 0.0);

        //2 days before yesterday amount total
        twoDaysBeforeYesTerDayAmountTotal = (double.tryParse(salesOverViewModel!.success!.db2yesterdayretailorder!.sumsubtotal) ?? 0.0) +
            (double.tryParse(salesOverViewModel!.success!.db2yesterdaystoreorder!.sumsubtotal ?? "0.0") ?? 0.0) +
            (double.tryParse(salesOverViewModel!.success!.db2yesterdaycollectstoreorder!.sumsubtotal) ?? 0.0);

        //current week amount total
        currentWeekAmountTotal = (double.tryParse(salesOverViewModel!.success!.day7retailorder!.sumsubtotal) ?? 0.0) +
            (double.tryParse(salesOverViewModel!.success!.day7storeorder!.sumsubtotal ?? "0.0") ?? 0.0) +
            (double.tryParse(salesOverViewModel!.success!.day7collectstoreorder!.sumsubtotal) ?? 0.0);

        //current month amount total
        currentMonthAmountTotal = (double.tryParse(salesOverViewModel!.success!.day30retailorder!.sumsubtotal) ?? 0.0) +
            (double.tryParse(salesOverViewModel!.success!.day30storeorder!.sumsubtotal ?? "0.0") ?? 0.0) +
            (double.tryParse(salesOverViewModel!.success!.day30collectstoreorder!.sumsubtotal) ?? 0.0);


      });
    });
  }

  @override
  @override
  void initState() {
    super.initState();
    getSalesOverViewData();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar:  customerAppBar(context, 'Sales Overview',),
      body:
      salesOverViewModel != null ?
      Padding(
        padding: EdgeInsets.only(left: 15,right: 15,top: 7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("TODAY",style: textHeading.copyWith(color: Colors.black),),
             giveHeight(3),
              todayTableData(),
              giveHeight(10),
              Text("YESTERDAY",style: textHeading.copyWith(color: Colors.black),),
              giveHeight(3),
              yesterdayTableData(),
              giveHeight(10),
              Text("DAY BEFORE YESTERDAY",style: textHeading.copyWith(color: Colors.black),),
              giveHeight(3),
              dayBeforeYesterdayTableData(),
              giveHeight(10),
              Text("2 DAYS BEFORE YESTERDAY",style: textHeading.copyWith(color: Colors.black),),
              giveHeight(3),
              twoDaysBeforeYesterdayTableData(),
              giveHeight(10),
              Text("CURRENT WEEK",style: textHeading.copyWith(color: Colors.black),),
              giveHeight(3),
              currentWeekTableData(),
              giveHeight(10),
              Text("CURRENT MONTH",style: textHeading.copyWith(color: Colors.black),),
              giveHeight(3),
              currentMonthTableData(),
              giveHeight(20)
            ],
          ),
        ),
      ):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25)),
    );
  }

  Table todayTableData() {
    return Table(
            border: TableBorder.all(color: Colors.grey.shade100),
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
                tableCell("Retails",),
                tableCell(salesOverViewModel!.success!.todayretailorder!.cnt.toString()),
                tableCell(formatter.format(double.parse(salesOverViewModel!.success!.todayretailorder!.sumsubtotal) / 1.15)),


              ]),
              TableRow(children: [
                tableCell("Store"),
                tableCell(salesOverViewModel!.success!.todaystoreorder!.cnt.toString()),
                tableCell(
                  salesOverViewModel!.success!.todaystoreorder!.sumsubtotal != null ?
                  formatter.format(double.parse(salesOverViewModel!.success!.todaystoreorder!.sumsubtotal) / 1.15):"R0.00",
                ),


              ]),
              TableRow(children: [
                tableCell("C & C"),
                tableCell(salesOverViewModel!.success!.todaycollectstoreorder!.cnt.toString()),
                tableCell(formatter.format(double.parse(salesOverViewModel!.success!.todaycollectstoreorder!.sumsubtotal) / 1.15)),

              ]),
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
                   todayCntTotal.toString(),
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
  Table yesterdayTableData() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade100),
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
                tableCell("Retails",),
                tableCell(salesOverViewModel!.success!.yesterdayretailorder!.cnt.toString()),
                tableCell(formatter.format(double.parse(salesOverViewModel!.success!.yesterdayretailorder!.sumsubtotal) / 1.15)),


              ]),
              TableRow(children: [
                tableCell("Store"),
                tableCell(salesOverViewModel!.success!.yesterdaystoreorder!.cnt.toString()),
                tableCell(
                  salesOverViewModel!.success!.yesterdaycollectstoreorder!.sumsubtotal != null ?
                  formatter.format(double.parse(salesOverViewModel!.success!.yesterdaycollectstoreorder!.sumsubtotal) / 1.15):"R0.00",
                ),


              ]),
              TableRow(children: [
                tableCell("C & C"),
                tableCell(salesOverViewModel!.success!.yesterdaycollectstoreorder!.cnt.toString()),
                tableCell(formatter.format(double.parse(salesOverViewModel!.success!.yesterdaycollectstoreorder!.sumsubtotal) / 1.15)),

              ]),
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
                   yesterDayCntTotal.toString(),
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
  formatter.format(double.parse(yesterDayAmountTotal.toString()) / 1.15),
                      style: userText.copyWith(fontSize: 9),
                      textAlign: TextAlign.center,
                    ),
                  ))),
                ]
              )
            ],
          );
  }
  Table dayBeforeYesterdayTableData() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade100),
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
                tableCell("Retails",),
                tableCell(salesOverViewModel!.success!.dbyesterdayretailorder!.cnt.toString()),
                tableCell(formatter.format(double.parse(salesOverViewModel!.success!.dbyesterdayretailorder!.sumsubtotal) / 1.15)),


              ]),
              TableRow(children: [
                tableCell("Store"),
                tableCell(salesOverViewModel!.success!.dbyesterdaystoreorder!.cnt.toString()),
                tableCell(
                  salesOverViewModel!.success!.dbyesterdaystoreorder!.sumsubtotal != null ?
                  formatter.format(double.parse(salesOverViewModel!.success!.dbyesterdaystoreorder!.sumsubtotal) / 1.15):"R0.00",
                ),


              ]),
              TableRow(children: [
                tableCell("C & C"),
                tableCell(salesOverViewModel!.success!.dbyesterdaycollectstoreorder!.cnt.toString()),
                tableCell(formatter.format(double.parse(salesOverViewModel!.success!.dbyesterdaycollectstoreorder!.sumsubtotal) / 1.15)),

              ]),
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
                   dayBeforeYesTerDayCntTotal.toString(),
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
  formatter.format(double.parse(dayBeforeYesTerDayAmountTotal.toString()) / 1.15),
                      style: userText.copyWith(fontSize: 9),
                      textAlign: TextAlign.center,
                    ),
                  ))),
                ]
              )
            ],
          );
  }
  Table twoDaysBeforeYesterdayTableData() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade100),
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
                tableCell("Retails",),
                tableCell(salesOverViewModel!.success!.db2yesterdayretailorder!.cnt.toString()),
                tableCell(formatter.format(double.parse(salesOverViewModel!.success!.db2yesterdayretailorder!.sumsubtotal) / 1.15)),


              ]),
              TableRow(children: [
                tableCell("Store"),
                tableCell(salesOverViewModel!.success!.db2yesterdaystoreorder!.cnt.toString()),
                tableCell(
                  salesOverViewModel!.success!.db2yesterdaystoreorder!.sumsubtotal != null ?
                  formatter.format(double.parse(salesOverViewModel!.success!.db2yesterdaystoreorder!.sumsubtotal) / 1.15):"R0.00",
                ),


              ]),
              TableRow(children: [
                tableCell("C & C"),
                tableCell(salesOverViewModel!.success!.db2yesterdaycollectstoreorder!.cnt.toString()),
                tableCell(formatter.format(double.parse(salesOverViewModel!.success!.db2yesterdaycollectstoreorder!.sumsubtotal) / 1.15)),

              ]),
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
                   twoDaysBeforeYesTerDayCntTotal.toString(),
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
  formatter.format(double.parse(twoDaysBeforeYesTerDayAmountTotal.toString()) / 1.15),
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
      border: TableBorder.all(color: Colors.grey.shade100),
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
                tableCell("Retails",),
                tableCell(salesOverViewModel!.success!.day7retailorder!.cnt.toString()),
                tableCell(formatter.format(double.parse(salesOverViewModel!.success!.day7retailorder!.sumsubtotal) / 1.15)),


              ]),
              TableRow(children: [
                tableCell("Store"),
                tableCell(salesOverViewModel!.success!.day7storeorder!.cnt.toString()),
                tableCell(
                  salesOverViewModel!.success!.day7storeorder!.sumsubtotal != null ?
                  formatter.format(double.parse(salesOverViewModel!.success!.day7storeorder!.sumsubtotal) / 1.15):"R0.00",
                ),


              ]),
              TableRow(children: [
                tableCell("C & C"),
                tableCell(salesOverViewModel!.success!.day7collectstoreorder!.cnt.toString()),
                tableCell(formatter.format(double.parse(salesOverViewModel!.success!.day7collectstoreorder!.sumsubtotal) / 1.15)),

              ]),
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
                   currentWeekCntTotal.toString(),
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
      border: TableBorder.all(color: Colors.grey.shade100),
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
                tableCell("Retails",),
                tableCell(salesOverViewModel!.success!.day30retailorder!.cnt.toString()),
                tableCell(formatter.format(double.parse(salesOverViewModel!.success!.day30retailorder!.sumsubtotal) / 1.15)),


              ]),
              TableRow(children: [
                tableCell("Store"),
                tableCell(salesOverViewModel!.success!.day30storeorder!.cnt.toString()),
                tableCell(
                  salesOverViewModel!.success!.day30storeorder!.sumsubtotal != null ?
                  formatter.format(double.parse(salesOverViewModel!.success!.day30storeorder!.sumsubtotal) / 1.15):"R0.00",
                ),


              ]),
              TableRow(children: [
                tableCell("C & C"),
                tableCell(salesOverViewModel!.success!.day30collectstoreorder!.cnt.toString()),
                tableCell(formatter.format(double.parse(salesOverViewModel!.success!.day30collectstoreorder!.sumsubtotal) / 1.15)),

              ]),
              TableRow(
                children: [
                  TableCell(child: Container(child:  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
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
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),

                    decoration: BoxDecoration(
                      color: Colors.white, // Header = Primary Color, Non-header = White
                      border: Border.all(color: Colors.grey.shade100,width: 0.5),

                    ),
                    child: Text(
                   currentMonthCntTotal.toString(),
                      style: userText.copyWith(fontSize: 9),
                      textAlign: TextAlign.center,
                    ),
                  ))),
                  TableCell(child: Container(child:  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
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
          fontSize: isHeader ? 9:10,
          fontWeight: isHeader ? FontWeight.w500 : FontWeight.normal,
          color: isHeader ? Colors.white : Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

}
