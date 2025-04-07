import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_table_cell_method.dart';
import 'package:volpes/resources/custom_loader.dart';

import '../../../common_repository/common_api_method.dart';
import '../../../models/top_10_models/retail_shopper_model.dart';
import '../../../resources/api_urls.dart';
import '../../../resources/common_texts_style.dart';
import '../../../resources/height_width.dart';
import '../common_appbar_drawer.dart';

class RetailShopper extends StatefulWidget {
  const RetailShopper({super.key});

  @override
  State<RetailShopper> createState() => _RetailShopperState();
}

class _RetailShopperState extends State<RetailShopper> {
  Repositories repositories = Repositories();
  TopRetailShopperModel? topRetailShopperModel;
  getTopRetailShopperData(){
    repositories.getApi(url: ApiUrls.retailShopperUrl).then((value){
      if(value != null) {
        setState(() {
          topRetailShopperModel = TopRetailShopperModel.fromJson(jsonDecode(value));
        });
      }


    });
  }
  @override
  void initState() {
    super.initState();
    getTopRetailShopperData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customerAppBar(context, "Top 10 Retail Shoppers"),
      body:
      topRetailShopperModel != null ?
      (topRetailShopperModel!.success!.topcust7daysall!.isNotEmpty == true ||
          topRetailShopperModel!.success!.topcust30daysall!.isNotEmpty == true ||
          topRetailShopperModel!.success!.topcusttodayall!.isNotEmpty == true )?
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              topRetailShopperModel!.success!.topcusttodayall != null && topRetailShopperModel!.success!.topcusttodayall!.isNotEmpty ?
              Text("TODAY",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              topRetailShopperModel!.success!.topcusttodayall != null && topRetailShopperModel!.success!.topcusttodayall!.isNotEmpty ?
              SizedBox(
                width: width,
                child: Table(
                  columnWidths: {
                    0:FlexColumnWidth(3),
                    1:FlexColumnWidth(3.2),
                    2:FlexColumnWidth(2.8),
                  },

                  children: [
                    TableRow(
                        children: [
                          tableCell("NAME",isHeader: true),
                          tableCell("EMAIL",isHeader: true),
                          tableCell("AMOUNT",isHeader: true),
                        ]
                    )
                  ],
                ),
              ):SizedBox(),
              SizedBox(
                width: width,
                // height: height*.3,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: topRetailShopperModel!.success!.topcusttodayall!.length,
                    itemBuilder: (context, index){
                      final tabData = topRetailShopperModel!.success!.topcusttodayall![index];
                      return
                        topStoreShopperTableData(name: "${(tabData.name.toString())} "+(tabData.lname.toString()), email: tabData.email.toString(), amt: tabData.totbuy.toString(),index: index);

                    }),
              ),
              giveHeight(10),
              topRetailShopperModel!.success!.topcust7daysall != null && topRetailShopperModel!.success!.topcust7daysall!.isNotEmpty ?
              Text("YESTERDAY",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              topRetailShopperModel!.success!.topcust7daysall != null && topRetailShopperModel!.success!.topcust7daysall!.isNotEmpty ?
              SizedBox(
                width: width,
                child: Table(
                  columnWidths: {
                    0:FlexColumnWidth(3),
                    1:FlexColumnWidth(3.2),
                    2:FlexColumnWidth(2.8),
                  },

                  children: [
                    TableRow(
                        children: [
                          tableCell("NAME",isHeader: true),
                          tableCell("EMAIL",isHeader: true),
                          tableCell("AMOUNT",isHeader: true),
                        ]
                    )
                  ],
                ),
              ):SizedBox(),
              SizedBox(
                width: width,
                // height: height*.3,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: topRetailShopperModel!.success!.topcust7daysall!.length,
                    itemBuilder: (context, index){
                      final tabData = topRetailShopperModel!.success!.topcust7daysall![index];
                      return
                        topStoreShopperTableData(name: "${(tabData.name.toString())} "+(tabData.lname.toString()), email: tabData.email.toString(), amt: tabData.totbuy.toString(),index: index);

                    }),
              ),
              giveHeight(10),
              topRetailShopperModel!.success!.topcust30daysall != null && topRetailShopperModel!.success!.topcust30daysall!.isNotEmpty ?
              Text("CURRENT MONTH",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              topRetailShopperModel!.success!.topcust30daysall != null && topRetailShopperModel!.success!.topcust30daysall!.isNotEmpty ?
              SizedBox(
                width: width,
                child: Table(
                  columnWidths: {
                    0:FlexColumnWidth(3),
                    1:FlexColumnWidth(3.2),
                    2:FlexColumnWidth(2.8),
                  },

                  children: [
                    TableRow(
                        children: [
                          tableCell("NAME",isHeader: true),
                          tableCell("EMAIL",isHeader: true),
                          tableCell("AMOUNT",isHeader: true),
                        ]
                    )
                  ],
                ),
              ):SizedBox(),
              Expanded(
                child: SizedBox(
                  width: width,
                  height: height*.3,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: topRetailShopperModel!.success!.topcust30daysall!.length,
                      itemBuilder: (context, index){
                        final tabData = topRetailShopperModel!.success!.topcust30daysall![index];
                        return
                          topStoreShopperTableData(name: "${(tabData.name.toString())} "+(tabData.lname.toString()), email: tabData.email.toString(), amt: tabData.totbuy.toString(),index: index);

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
    required String amt,
    int? index
  }) {
    return Table(
      columnWidths: {
        0:FlexColumnWidth(3),
        1:FlexColumnWidth(3.2),
        2:FlexColumnWidth(2.8),
      },
      children: [
        TableRow(children: [
          tableCell(name, rowIndex: index),
          tableCell(email, rowIndex: index),
          tableCell(formatter.format(double.tryParse(amt)), rowIndex: index),
        ]),
      ],
    );
  }

}
