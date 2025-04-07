import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_table_cell_method.dart';
import 'package:volpes/resources/custom_loader.dart';
import '../../../common_repository/common_api_method.dart';
import '../../../models/top_10_models/cc_sales_store.dart';
import '../../../resources/api_urls.dart';
import '../../../resources/common_texts_style.dart';
import '../../../resources/height_width.dart';

import '../common_appbar_drawer.dart';

class CCSalesStore extends StatefulWidget {
  const CCSalesStore({super.key});

  @override
  State<CCSalesStore> createState() => _CCSalesStoreState();
}

class _CCSalesStoreState extends State<CCSalesStore> {
  Repositories repositories = Repositories();
  TopCCSaleStoreModel? topCCSaleStoreModel;
  getTopCCSalesStoreData(){
    repositories.getApi(url: ApiUrls.ccSalesStoreUrl).then((value){
      topCCSaleStoreModel = TopCCSaleStoreModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getTopCCSalesStoreData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customerAppBar(context, "Top 10 C & C Sales Per Store"),
      body:
      topCCSaleStoreModel != null ?
          (topCCSaleStoreModel!.success!.topccstore7daysall!.isNotEmpty == true ||
          topCCSaleStoreModel!.success!.topccstoretodayall!.isNotEmpty  == true ||
          topCCSaleStoreModel!.success!.topccstore30daysall!.isNotEmpty  == true)?
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              topCCSaleStoreModel!.success!.topccstoretodayall != null && topCCSaleStoreModel!.success!.topccstoretodayall!.isNotEmpty ?
              Text("TODAY",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              topCCSaleStoreModel!.success!.topccstoretodayall != null && topCCSaleStoreModel!.success!.topccstoretodayall!.isNotEmpty ?
              SizedBox(
                width: width,
                child: Table(
                  columnWidths: {
                    0:FlexColumnWidth(3),
                    1:FlexColumnWidth(2.5),
                    2:FlexColumnWidth(3),
                  },

                  children: [
                    TableRow(
                        children: [
                          tableCell("NAME",isHeader: true),
                          tableCell("ORDER",isHeader: true),
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
                  padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    itemCount: topCCSaleStoreModel!.success!.topccstoretodayall!.length,
                    itemBuilder: (context, index){
                      final tabData = topCCSaleStoreModel!.success!.topccstoretodayall![index];
                      return
                        topStoreShopperTableData(name: tabData.storename.toString(), email: tabData.totord.toString(), amt: tabData.totbuy.toString(),index: index);

                    }),
              ),
              giveHeight(10),
              topCCSaleStoreModel!.success!.topccstore7daysall != null && topCCSaleStoreModel!.success!.topccstore7daysall!.isNotEmpty ?
              Text("YESTERDAY",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              topCCSaleStoreModel!.success!.topccstore7daysall != null && topCCSaleStoreModel!.success!.topccstore7daysall!.isNotEmpty ?
              SizedBox(
                width: width,
                child: Table(
                  columnWidths: {
                    0:FlexColumnWidth(3),
                    1:FlexColumnWidth(2.5),
                    2:FlexColumnWidth(3),
                  },

                  children: [
                    TableRow(
                        children: [
                          tableCell("NAME",isHeader: true),
                          tableCell("ORDER",isHeader: true),
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
                    itemCount: topCCSaleStoreModel!.success!.topccstore7daysall!.length,
                    itemBuilder: (context, index){
                      final tabData = topCCSaleStoreModel!.success!.topccstore7daysall![index];
                      return
                        topStoreShopperTableData(name: tabData.storename.toString(), email: tabData.totord.toString(), amt: tabData.totbuy.toString(),index: index);

                    }),
              ),
              giveHeight(10),
              topCCSaleStoreModel!.success!.topccstore30daysall != null && topCCSaleStoreModel!.success!.topccstore30daysall!.isNotEmpty ?
              Text("CURRENT MONTH",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              topCCSaleStoreModel!.success!.topccstore30daysall != null && topCCSaleStoreModel!.success!.topccstore30daysall!.isNotEmpty ?
              SizedBox(
                width: width,
                child: Table(
                  columnWidths: {
                    0:FlexColumnWidth(3),
                    1:FlexColumnWidth(2.5),
                    2:FlexColumnWidth(3),
                  },

                  children: [
                    TableRow(
                        children: [
                          tableCell("NAME",isHeader: true),
                          tableCell("ORDER",isHeader: true),
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
                      itemCount: topCCSaleStoreModel!.success!.topccstore30daysall!.length,
                      itemBuilder: (context, index){
                        final tabData = topCCSaleStoreModel!.success!.topccstore30daysall![index];
                        return
                          topStoreShopperTableData(name: tabData.storename.toString(), email: tabData.totord.toString(), amt: tabData.totbuy.toString(),index: index);

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
        1:FlexColumnWidth(2.5),
        2:FlexColumnWidth(3),
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
