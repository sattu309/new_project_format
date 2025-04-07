import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Resources/app_colors.dart';
import '../../common_repository/common_api_method.dart';
import '../../models/furniture_rugs.dart';
import '../../resources/api_urls.dart';
import '../../resources/common_texts_style.dart';
import '../../resources/custom_loader.dart';
import '../../resources/height_width.dart';
import 'common_appbar_drawer.dart';
import 'common_table_cell_method.dart';

class CCFurnitureRugs extends StatefulWidget {
  const CCFurnitureRugs({super.key});

  @override
  State<CCFurnitureRugs> createState() => _CCFurnitureRugsState();
}

class _CCFurnitureRugsState extends State<CCFurnitureRugs> {
  Repositories repositories = Repositories();
  FurnitureRugsModel? furnitureRugsModel;
  getFurnitureRugsData(){
    repositories.getApi(url: ApiUrls.furnitureRugsUrl).then((value){
      furnitureRugsModel = FurnitureRugsModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getFurnitureRugsData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: customerAppBar(context, "C & C Furniture and Rugs"),
      body:
          furnitureRugsModel != null ?
          (furnitureRugsModel!.success!.ccorder!.isNotEmpty == true)?
      SingleChildScrollView(
        scrollDirection:Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 7),
          child: Column(
            children: [
              giveHeight(3),
              furnitureRugsModel!.success!.ccorder!.isNotEmpty == true ?
              SizedBox(
                width: width,
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(2.5),
                    1: FlexColumnWidth(2.6),
                    2: FlexColumnWidth(2.2),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(2),

                  },
                  children: [
                    TableRow(children: [
                      tableCell("STORE", isHeader: true,),
                      tableCell("PRODUCTS", isHeader: true),
                      tableCell("SKU", isHeader: true),
                      tableCell("QTY", isHeader: true),
                      tableCell("AMOUNT", isHeader: true),
                    ]),
                  ],
                ),
              ):SizedBox(),
              SizedBox(
                width: width,
                // height: 400,
                child: ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    itemCount: furnitureRugsModel!.success!.ccorder!.length,
                    itemBuilder: (context, index){
                    final tabData = furnitureRugsModel!.success!.ccorder![index];
                  return
                    todayTableData(itemName: tabData.storename.toString(), retailValue: tabData.productname.toString(), storeValue: tabData.productcode.toString(), ccValue: tabData.totqty.toString(), totalValue: tabData.totamount.toString(),index: index);

                }),
              ),
              giveHeight(10),
            ],
          ),
        ),
      )
              :Center(child: Text("No Record Found",style: userText,),)
              :Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25
          ),),
    );
  }
}
