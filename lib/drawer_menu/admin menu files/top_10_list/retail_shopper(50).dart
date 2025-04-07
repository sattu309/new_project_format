import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_table_cell_method.dart';
import 'package:volpes/resources/custom_loader.dart';
import '../../../common_repository/common_api_method.dart';
import '../../../models/top_10_models/retail_shopper(50).dart';
import '../../../resources/api_urls.dart';
import '../../../resources/common_texts_style.dart';
import '../../../resources/height_width.dart';
import '../common_appbar_drawer.dart';

class RetailsShoppersList extends StatefulWidget {
  const RetailsShoppersList({super.key});

  @override
  State<RetailsShoppersList> createState() => _RetailsShoppersListState();
}

class _RetailsShoppersListState extends State<RetailsShoppersList> {
  Repositories repositories = Repositories();
  FiftyRetailShoopersModel? fiftyRetailShoopersModel;
  getTop50RetailsShopperData(){
    repositories.getApi(url: ApiUrls.retailShopper50Url).then((value){
      fiftyRetailShoopersModel = FiftyRetailShoopersModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getTop50RetailsShopperData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: customerAppBar(context, "Top 50 Retail Shoppers (Overall)"),
      body:
      fiftyRetailShoopersModel != null ?
      (fiftyRetailShoopersModel!.success!.top50cust!.isNotEmpty == true ) ?
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              fiftyRetailShoopersModel!.success!.top50cust!.isNotEmpty == true ?
              SizedBox(
                width: width,
                child: Table(
                  columnWidths: {
                    0:FlexColumnWidth(3.3),
                    1:FlexColumnWidth(4.2),
                    2:FlexColumnWidth(2),
                    3:FlexColumnWidth(3),
                  },

                  children: [
                    TableRow(
                        children: [
                          tableCell("NAME",isHeader: true),
                          tableCell("EMAIL",isHeader: true),
                          tableCell("ORDERS",isHeader: true),
                          tableCell("AMOUNT",isHeader: true),
                        ]
                    )
                  ],
                ),
              ):SizedBox(),
              Expanded(
                child: SizedBox(
                  width: width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.vertical,
                      itemCount: fiftyRetailShoopersModel!.success!.top50cust!.length,
                      itemBuilder: (context, index){
                        final tabData = fiftyRetailShoopersModel!.success!.top50cust![index];
                        return
                          topStoreShopperTableData(name: tabData.name.toString(), email: tabData.email.toString(), amt: tabData.totamount.toString(),index: index, orders: tabData.cnt.toString());

                      }),
                ),
              ),
              giveHeight(10),


            ],
          ),
        ),
      )
          :Center(child: Text("No Record Found",style: userText,),)
          :Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25),),
    );
  }
  Table topStoreShopperTableData({
    required String name,
    required String email,
    required String orders,
    required String amt,
    int? index
  }) {
    return Table(
      columnWidths: {
        0:FlexColumnWidth(3.3),
        1:FlexColumnWidth(4.2),
        2:FlexColumnWidth(2),
        3:FlexColumnWidth(3),
      },
      children: [

        TableRow(children: [
          tableCell(name, rowIndex: index),
          tableCell(email, rowIndex: index),
          tableCell(orders , rowIndex: index),
          tableCell(formatter.format(double.tryParse(amt)) , rowIndex: index),
        ]),
      ],
    );
  }

}
