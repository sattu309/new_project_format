import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_table_cell_method.dart';
import 'package:volpes/resources/custom_loader.dart';
import '../../../common_repository/common_api_method.dart';
import '../../../models/top_10_models/store_shoppers(orverAll).dart';
import '../../../resources/api_urls.dart';
import '../../../resources/common_texts_style.dart';
import '../../../resources/height_width.dart';
import '../common_appbar_drawer.dart';

class StoreShopperOverAll extends StatefulWidget {
  const StoreShopperOverAll({super.key});

  @override
  State<StoreShopperOverAll> createState() => _StoreShopperOverAllState();
}

class _StoreShopperOverAllState extends State<StoreShopperOverAll> {
  Repositories repositories = Repositories();
  TopStoreShopperOverAllModel? topStoreShopperOverAllModel;
  getTopStoreShopperOverallData(){
    repositories.getApi(url: ApiUrls.storeShopperOverAllUrl).then((value){
      topStoreShopperOverAllModel = TopStoreShopperOverAllModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getTopStoreShopperOverallData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: customerAppBar(context, "Top 10 Store Shoppers (Overall)"),
      body:
      topStoreShopperOverAllModel != null ?
      (topStoreShopperOverAllModel!.success!.top10store!.isNotEmpty == true)?
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              topStoreShopperOverAllModel!.success!.top10store!.isNotEmpty == true ?
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
              SizedBox(
                width: width,
                // height: 400,
                child: ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    itemCount: topStoreShopperOverAllModel!.success!.top10store!.length,
                    itemBuilder: (context, index){
                      final tabData = topStoreShopperOverAllModel!.success!.top10store![index];
                      return
                        topStoreShopperTableData(name: tabData.name.toString(), email: tabData.email.toString(), amt: tabData.totamount.toString(),index: index, orders: tabData.cnt.toString());

                    }),
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
