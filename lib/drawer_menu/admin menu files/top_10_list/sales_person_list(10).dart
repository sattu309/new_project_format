import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_table_cell_method.dart';
import 'package:volpes/resources/custom_loader.dart';
import '../../../common_repository/common_api_method.dart';
import '../../../models/top_10_models/sale_person(10).dart';
import '../../../resources/api_urls.dart';
import '../../../resources/common_texts_style.dart';
import '../../../resources/height_width.dart';
import '../common_appbar_drawer.dart';

class SalesPersonList extends StatefulWidget {
  const SalesPersonList({super.key});

  @override
  State<SalesPersonList> createState() => _SalesPersonListState();
}

class _SalesPersonListState extends State<SalesPersonList> {
  final ScrollController _controller = ScrollController();
  Repositories repositories = Repositories();
  TopTenSalesPersonModel? topTenSalesPersonModel;
  getTopSalesPersonData(){
    repositories.getApi(url: ApiUrls.salesPersonListUrl).then((value){
      topTenSalesPersonModel = TopTenSalesPersonModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getTopSalesPersonData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customerAppBar(context, "Top 10 Sales Persons"),
      body:
      topTenSalesPersonModel != null ?
      (topTenSalesPersonModel!.success!.top10salespeople!.isNotEmpty == true)?
      Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                topTenSalesPersonModel!.success!.top10salespeople!.isNotEmpty == true ?
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
                            tableCell("SALES PERSON",isHeader: true),
                            tableCell("STORENAME",isHeader: true),
                            tableCell("ORDERS",isHeader: true),
                            tableCell("AMOUNT",isHeader: true),
                          ]
                      )
                    ],
                  ),
                ):SizedBox(),
                SizedBox(
                  width: width,
                   // height: height*0.3,
                  child: Scrollbar(
                    thickness: 20,
                    thumbVisibility: true,
                    controller: _controller,

                    child: ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        // scrollDirection: Axis.vertical,
                        itemCount: topTenSalesPersonModel!.success!.top10salespeople!.length,
                        itemBuilder: (context, index){
                          final tabData = topTenSalesPersonModel!.success!.top10salespeople![index];
                          return
                            topStoreShopperTableData(name: "${tabData.firstName.toString() }"+"${tabData.lastName.toString()}", email: tabData.storeName.toString(), amt: tabData.totamount.toString(),index: index, orders: tabData.cnt.toString());

                        }),
                  ),
                ),
                giveHeight(10),


              ],
            ),
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
