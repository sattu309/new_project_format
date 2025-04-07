import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_table_cell_method.dart';
import 'package:volpes/resources/custom_loader.dart';

import '../../../common_repository/common_api_method.dart';
import '../../../models/top_10_models/store_shopper_model.dart';
import '../../../resources/api_urls.dart';
import '../../../resources/common_texts_style.dart';
import '../../../resources/height_width.dart';
import '../common_appbar_drawer.dart';

class StoreShopper extends StatefulWidget {
  const StoreShopper({super.key});

  @override
  State<StoreShopper> createState() => _StoreShopperState();
}

class _StoreShopperState extends State<StoreShopper> {
  Repositories repositories = Repositories();
  TopStoreShopperModel? topStoreShopperModel;
  getTopStoreShopperData(){
    repositories.getApi(url: ApiUrls.storeShopperUrl).then((value){
      topStoreShopperModel = TopStoreShopperModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getTopStoreShopperData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: customerAppBar(context, "Top 10 Store Shoppers"),
      body:
      topStoreShopperModel != null ?
          (topStoreShopperModel!.success!.topstore7daysall?.isNotEmpty == true ||
              topStoreShopperModel!.success!.topstore30daysall?.isNotEmpty == true ||
              topStoreShopperModel!.success!.topstoretodayall?.isNotEmpty == true) ?
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              topStoreShopperModel!.success!.topstoretodayall != null && topStoreShopperModel!.success!.topstoretodayall!.isNotEmpty ?
              Text("TODAY",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              topStoreShopperModel!.success!.topstoretodayall != null && topStoreShopperModel!.success!.topstoretodayall!.isNotEmpty ?
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
                // height: 400,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: topStoreShopperModel!.success!.topstoretodayall!.length,
                    itemBuilder: (context, index){
                      final tabData = topStoreShopperModel!.success!.topstoretodayall![index];
                      return
                        topStoreShopperTableData(name: tabData.name.toString(), email: tabData.email.toString(), amt: tabData.totbuy.toString(),index: index);

                    }),
              ),
              giveHeight(10),
              topStoreShopperModel!.success!.topstore7daysall != null && topStoreShopperModel!.success!.topstore7daysall!.isNotEmpty ?
              Text("YESTERDAY",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              topStoreShopperModel!.success!.topstore7daysall != null && topStoreShopperModel!.success!.topstore7daysall!.isNotEmpty ?
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
              Flexible(
                child: SizedBox(
                  width: width,
                  // height: 400,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: topStoreShopperModel!.success!.topstore7daysall!.length,
                      itemBuilder: (context, index){
                        final tabData = topStoreShopperModel!.success!.topstore7daysall![index];
                        return
                          topStoreShopperTableData(name: tabData.name.toString(), email: tabData.email.toString(), amt: tabData.totbuy.toString(),index: index);

                      }),
                ),
              ),
              giveHeight(10),
              topStoreShopperModel!.success!.topstore30daysall != null && topStoreShopperModel!.success!.topstore30daysall!.isNotEmpty ?
              Text("CURRENT MONTH",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              topStoreShopperModel!.success!.topstore30daysall != null && topStoreShopperModel!.success!.topstore30daysall!.isNotEmpty ?
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
                  // height: 400,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: topStoreShopperModel!.success!.topstore30daysall!.length,
                      itemBuilder: (context, index){
                        final tabData = topStoreShopperModel!.success!.topstore30daysall![index];
                        return
                          topStoreShopperTableData(name: tabData.name.toString(), email: tabData.email.toString(), amt: tabData.totbuy.toString(),index: index);
                
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
          tableCell(formatter.format(double.tryParse(amt)) , rowIndex: index),
        ]),
      ],
    );
  }

}
