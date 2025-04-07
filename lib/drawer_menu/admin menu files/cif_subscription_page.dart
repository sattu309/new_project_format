import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_table_cell_method.dart';

import '../../common_repository/common_api_method.dart';
import '../../models/cif_subscription_model.dart';
import '../../resources/api_urls.dart';
import '../../resources/common_texts_style.dart';
import '../../resources/custom_loader.dart';
import '../../resources/height_width.dart';
import 'common_appbar_drawer.dart';

class CifSubscriptionPage extends StatefulWidget {
  const CifSubscriptionPage({super.key});

  @override
  State<CifSubscriptionPage> createState() => _CifSubscriptionPageState();
}

class _CifSubscriptionPageState extends State<CifSubscriptionPage> {
  Repositories repositories = Repositories();
  CifSubscriptionModel? cifSubscriptionModel;
  getCIFSUBSCRIONData(){
    repositories.getApi(url: ApiUrls.cifSubsriptionUrl).then((value){
      cifSubscriptionModel = CifSubscriptionModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getCIFSUBSCRIONData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customerAppBar(context, "Store CIF Subscriptions"),
      body:
          cifSubscriptionModel != null ?
          (cifSubscriptionModel!.success!.storecifdata!.isNotEmpty == true)?
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 7),
          child: Column(
            children: [
              cifSubscriptionModel!.success!.storecifdata!.isNotEmpty == true ?
              SizedBox(
                width: width,
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(3)
                  },
                  children: [
                    TableRow(
                      children: [
                        tableCell("STORE",isHeader: true),
                        tableCell("TODAY SUBSCRIPTIONS",isHeader: true),
                        tableCell("THIS MONTH SUBSCRIPTIONS",isHeader: true),
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
                      // scrollDirection: Axis.vertical,
                      itemCount: cifSubscriptionModel!.success!.storecifdata!.length,
                      itemBuilder: (context, index){
                        final tabData = cifSubscriptionModel!.success!.storecifdata![index];
                        return
                          cifSubsriptionsTableData(storeValue: tabData.storename.toString(), todaySubsription: tabData.todaycif.toString(), thisMonthSubscription: tabData.monthcif.toString(),index: index);
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
  Table cifSubsriptionsTableData({
    required String storeValue,
    required String todaySubsription,
    required String thisMonthSubscription,
    int? index
  }) {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3)
      },
      children: [
        TableRow(children: [
          tableCell(storeValue, rowIndex: index),
          tableCell(todaySubsription != "null" ? todaySubsription : "-", rowIndex: index),
          tableCell(thisMonthSubscription != "null" ? thisMonthSubscription : "-", rowIndex: index),
        ]),
      ],
    );
  }
}
