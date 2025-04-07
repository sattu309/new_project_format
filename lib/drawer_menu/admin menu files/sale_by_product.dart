import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/common_repository/common_api_method.dart';
import 'package:volpes/resources/api_urls.dart';
import 'package:volpes/resources/custom_loader.dart';

import '../../models/sale_by_product_model.dart';
import '../../resources/common_texts_style.dart';
import '../../resources/height_width.dart';
import 'common_appbar_drawer.dart';
import 'common_table_cell_method.dart';

class SaleByProduct extends StatefulWidget {
  const SaleByProduct({super.key});

  @override
  State<SaleByProduct> createState() => _SaleByProductState();
}

class _SaleByProductState extends State<SaleByProduct> {
  Repositories repositories = Repositories();
  SaleByProdcutModel? saleByProdcutModel;
  getSaleByProductData(){
    repositories.getApi(url: ApiUrls.saleByProductUrl).then((value){
      saleByProdcutModel = SaleByProdcutModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getSaleByProductData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: customerAppBar(context, "Sale By Product"),
      body:
      saleByProdcutModel != null ?
      (saleByProdcutModel!.success!.topsellertoday!.isNotEmpty == true ||
          saleByProdcutModel!.success!.topseller7days!.isNotEmpty == true ||
          saleByProdcutModel!.success!.topseller30days!.isNotEmpty == true) ?
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 0,top: 7),
          child: Column(
            children: [
              saleByProdcutModel!.success!.topsellertoday!.isNotEmpty == true ?
              Text("TODAY",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              saleByProdcutModel!.success!.topsellertoday!.isNotEmpty == true ?
              Table(
                columnWidths: {
                  0: FractionColumnWidth(0.35), // First column width
                  1: FractionColumnWidth(0.15),
                  2: FractionColumnWidth(0.15),
                  3: FractionColumnWidth(0.15),
                  4: FractionColumnWidth(0.15),
                },
                children: [
                  TableRow(children: [
                    tableCell("PRODUCTS", isHeader: true,),
                    tableCell("RETAIL", isHeader: true),
                    tableCell("STORE", isHeader: true),
                    tableCell("C & C", isHeader: true),
                    tableCell("T0TAL", isHeader: true),
                  ]),
                ],
              ):SizedBox(),
              ...List.generate(
                  saleByProdcutModel!.success!.topsellertoday!.length, (index){
                final tabData = saleByProdcutModel!.success!.topsellertoday![index];
                Color rowColor = index.isEven ? Colors.grey[200]! : Colors.white;
                return todayTableData(itemName: tabData.productname, retailValue: tabData.retailsell.toString(), storeValue: tabData.storesell.toString(), ccValue: tabData.ccsell.toString(), totalValue: tabData.totsell,index: index);
              }),
              giveHeight(10),
              saleByProdcutModel!.success!.topseller7days!.isNotEmpty == true ?
              Text("YESTERDAY",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              saleByProdcutModel!.success!.topseller7days!.isNotEmpty == true ?
              Table(
                columnWidths: {
                  0: FractionColumnWidth(0.35), // First column width
                  1: FractionColumnWidth(0.15),
                  2: FractionColumnWidth(0.15),
                  3: FractionColumnWidth(0.15),
                  4: FractionColumnWidth(0.15),
                },
                children: [
                  TableRow(children: [
                    tableCell("PRODUCTS", isHeader: true,),
                    tableCell("RETAIL", isHeader: true),
                    tableCell("STORE", isHeader: true),
                    tableCell("C & C", isHeader: true),
                    tableCell("T0TAL", isHeader: true),
                  ]),
                ],
              ):SizedBox(),
              ...List.generate(
                  saleByProdcutModel!.success!.topseller7days!.length, (index){
                final tabData = saleByProdcutModel!.success!.topseller7days![index];
                return todayTableData(itemName: tabData.productname, retailValue: tabData.retailsell.toString(), storeValue: tabData.storesell.toString(), ccValue: tabData.ccsell.toString(), totalValue: tabData.totsell,index: index);
              }),
              giveHeight(10),
              saleByProdcutModel!.success!.topseller30days!.isNotEmpty == true ?
              Text("CURRENT MONTH",style: textHeading.copyWith(color: Colors.black),):SizedBox(),
              giveHeight(3),
              saleByProdcutModel!.success!.topseller30days!.isNotEmpty == true ?
              Table(
                columnWidths: {
                  0: FractionColumnWidth(0.35), // First column width
                  1: FractionColumnWidth(0.15),
                  2: FractionColumnWidth(0.15),
                  3: FractionColumnWidth(0.15),
                  4: FractionColumnWidth(0.15),
                },
                children: [
                  TableRow(children: [
                    tableCell("PRODUCTS", isHeader: true,),
                    tableCell("RETAIL", isHeader: true),
                    tableCell("STORE", isHeader: true),
                    tableCell("C & C", isHeader: true),
                    tableCell("T0TAL", isHeader: true),
                  ]),
                ],
              ):SizedBox(),
              ...List.generate(
                  saleByProdcutModel!.success!.topseller30days!.length, (index){
                final tabData = saleByProdcutModel!.success!.topseller30days![index];
                return todayTableData(itemName: tabData.productname, retailValue: tabData.retailsell.toString(), storeValue: tabData.storesell.toString(), ccValue: tabData.ccsell.toString(), totalValue: tabData.totsell,index: index);
              }),
              giveHeight(10),
            ],
          ),
        ),
      )
          :Center(child: Text("No Record Found",style: userText,),)
          : Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25
      ),),
    );
  }
  Table todayTableData({
    required String itemName,
    required String retailValue,
    required String storeValue,
    required String ccValue,
    required String totalValue,
    int? index
  }) {
    return Table(
      // border: TableBorder.all(),
      columnWidths: {
        0: FractionColumnWidth(0.35), // First column width
        1: FractionColumnWidth(0.15),
        2: FractionColumnWidth(0.15),
        3: FractionColumnWidth(0.15),
        4: FractionColumnWidth(0.15),
      },
      children: [

        TableRow(children: [
          tableCell(itemName,rowIndex: index),
          tableCell(retailValue,rowIndex: index),
          tableCell(storeValue,rowIndex: index),
          tableCell(ccValue,rowIndex: index),
          tableCell(totalValue,rowIndex: index),


        ]),

      ],
    );
  }
}
