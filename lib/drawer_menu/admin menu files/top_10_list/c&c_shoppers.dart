import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_table_cell_method.dart';
import 'package:volpes/resources/custom_loader.dart';
import '../../../common_repository/common_api_method.dart';
import '../../../models/top_10_models/cc_shopper_model.dart';
import '../../../resources/api_urls.dart';
import '../../../resources/common_texts_style.dart';
import '../../../resources/height_width.dart';
import '../common_appbar_drawer.dart';

class CCShoppers extends StatefulWidget {
  const CCShoppers({super.key});

  @override
  State<CCShoppers> createState() => _CCShoppersState();
}

class _CCShoppersState extends State<CCShoppers> {
  Repositories repositories = Repositories();
  TopCCShopperModel? topCCShopperModel;
  getTopCCShopperData(){
    repositories.getApi(url: ApiUrls.ccShopperUrl).then((value){
      topCCShopperModel = TopCCShopperModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getTopCCShopperData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customerAppBar(context, "Top 10 C & C Shoppers"),
      body:
      topCCShopperModel != null ?
      (topCCShopperModel!.success!.topcc7daysall!.isNotEmpty == true ||
          topCCShopperModel!.success!.topcc30daysall!.isNotEmpty == true ||
          topCCShopperModel!.success!.topcctodayall!.isNotEmpty == true )?
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              topCCShopperModel!.success!.topcctodayall != null && topCCShopperModel!.success!.topcctodayall!.isNotEmpty ?
              Text("TODAY",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              topCCShopperModel!.success!.topcctodayall != null && topCCShopperModel!.success!.topcctodayall!.isNotEmpty ?
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
                      padding: EdgeInsets.zero,
                      itemCount: topCCShopperModel!.success!.topcctodayall!.length,
                      itemBuilder: (context, index){
                        final tabData = topCCShopperModel!.success!.topcctodayall![index];
                        return
                          topStoreShopperTableData(name: "${(tabData.name.toString())} "+(tabData.lname.toString()), email: tabData.email.toString(), amt: tabData.totbuy.toString(),index: index);

                      }),
                ),
              ),
              giveHeight(10),
              topCCShopperModel!.success!.topcc7daysall != null && topCCShopperModel!.success!.topcc7daysall!.isNotEmpty ?
              Text("YESTERDAY",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              topCCShopperModel!.success!.topcc7daysall != null && topCCShopperModel!.success!.topcc7daysall!.isNotEmpty ?
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
                // height: height*0.3,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: topCCShopperModel!.success!.topcc7daysall!.length,
                    itemBuilder: (context, index){
                      final tabData = topCCShopperModel!.success!.topcc7daysall![index];
                      return
                        topStoreShopperTableData(name: "${(tabData.name.toString())} "+(tabData.lname.toString()), email: tabData.email.toString(), amt: tabData.totbuy.toString(),index: index);

                    }),
              ),
              giveHeight(10),
              topCCShopperModel!.success!.topcc30daysall != null && topCCShopperModel!.success!.topcc30daysall!.isNotEmpty ?
              Text("CURRENT MONTH",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              topCCShopperModel!.success!.topcc30daysall != null && topCCShopperModel!.success!.topcc30daysall!.isNotEmpty ?
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
                  height: height,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: topCCShopperModel!.success!.topcc30daysall!.length,
                      itemBuilder: (context, index){
                        final tabData = topCCShopperModel!.success!.topcc30daysall![index];
                        return
                          topStoreShopperTableData(name: "${(tabData.name.toString())} ${tabData.lname}", email: tabData.email.toString(), amt: tabData.totbuy.toString(),index: index);

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
