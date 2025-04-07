import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:volpes/resources/api_urls.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';

import '../../common_repository/common_api_method.dart';
import '../../models/tfg_money_model.dart';
import 'common_appbar_drawer.dart';

class TFGMoney extends StatefulWidget {
  const TFGMoney({super.key});

  @override
  State<TFGMoney> createState() => _TFGMoneyState();
}

class _TFGMoneyState extends State<TFGMoney> {
  Repositories repositories = Repositories();
  TFGMoneyModel? tfgMoneyModel;
  double totalSales = 0.0;
  int totalOrders = 0;
  getTfgData(){
    repositories.getApi(url: ApiUrls.tfgUrl).then((value){
      tfgMoneyModel = TFGMoneyModel.fromJson(jsonDecode(value));
      setState(() {
        // totalSales = (double.tryParse(tfgMoneyModel?.success?.todaycollectstoreordertfg?.sumsubtotal?.toString() ?? "0") ?? 0.0) / 1.15 +
        //     (double.tryParse(tfgMoneyModel?.success?.todayretailordertfg?.sumsubtotal?.toString() ?? "0") ?? 0.0) / 1.15 +
        //     (double.tryParse(tfgMoneyModel?.success?.todaystoreordertfg?.sumsubtotal?.toString() ?? "0") ?? 0.0) / 1.15;

        totalSales = (double.parse(tfgMoneyModel!.success!.todaycollectstoreordertfg!.sumsubtotal.toString()) / 1.15)+
            (double.parse(tfgMoneyModel!.success!.todayretailordertfg!.sumsubtotal.toString()) / 1.15)+
            (double.parse(tfgMoneyModel!.success!.todaystoreordertfg!.sumsubtotal.toString()) / 1.15);

        totalOrders = (tfgMoneyModel!.success!.todaycollectstoreordertfg!.cnt?.toInt() ?? 0) +
            (tfgMoneyModel!.success!.todayretailordertfg!.cnt?.toInt() ?? 0) +
            (tfgMoneyModel!.success!.todaystoreordertfg!.cnt?.toInt() ?? 0);



      });
    });
  }
  @override
  @override
  void initState() {
    super.initState();
    getTfgData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customerAppBar(context, "My TFG Moeny"),
      body:
      tfgMoneyModel != null ?
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              giveHeight(5),
              Image.asset('assets/images/tfg_img.png',),
              giveHeight(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryClr,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        children: [
                          Text("TOTAL SALES",style: textHeading.copyWith(color: Colors.white,fontSize: 9,fontWeight: FontWeight.w400),),
                          giveHeight(2),
                          Text(formatter.format(totalSales),style: userText.copyWith(color: Colors.white,fontSize: 11),)
                        ],
                      ),
                    ),
                  ),
                  giveWidth(10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryClr,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        children: [

                          Text("TOTAL ORDERS",style: textHeading.copyWith(color: Colors.white,fontSize: 9,fontWeight: FontWeight.w400),),
                          giveHeight(2),
                          Text(totalOrders.toString(),style: userText.copyWith(color: Colors.white,fontSize: 11),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              giveHeight(10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                      decoration: BoxDecoration(
                          color: AppColors.primaryClr,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        children: [
                          Text("TOTAL AVERAGE ORDER VALUE",style: textHeading.copyWith(color: Colors.white,fontSize: 9,fontWeight: FontWeight.w400),),
                          giveHeight(2),
                          Text(formatter.format(double.tryParse(tfgMoneyModel!.success!.avgordvaltfg.toString())),style: userText.copyWith(color: Colors.white,fontSize: 11),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              giveHeight(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                      decoration: BoxDecoration(
                          color: AppColors.primaryClr,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        children: [
                          Text("CREDIT SALES",style: textHeading.copyWith(color: Colors.white,fontSize: 9,fontWeight: FontWeight.w400),),
                          giveHeight(2),
                          Text(formatter.format(double.parse(tfgMoneyModel!.success!.todayretailordertfg!.sumsubtotal.toString()) / 1.15),style: userText.copyWith(color: Colors.white,fontSize: 11),)
                        ],
                      ),
                    ),
                  ),
                  giveWidth(10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                      decoration: BoxDecoration(
                          color: AppColors.primaryClr,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        children: [
                          Text("CREDIT ORDERS",style: textHeading.copyWith(color: Colors.white,fontSize: 9,fontWeight: FontWeight.w400),),
                          giveHeight(2),
                          Text(tfgMoneyModel!.success!.todayretailordertfg!.cnt.toString(),style: userText.copyWith(color: Colors.white,fontSize: 11),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              giveHeight(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                      decoration: BoxDecoration(
                          color: AppColors.primaryClr,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        children: [
                          Text("STAFF SALES",style: textHeading.copyWith(color: Colors.white,fontSize: 9,fontWeight: FontWeight.w400),),
                          giveHeight(2),
                          Text(formatter.format(double.parse(tfgMoneyModel!.success!.todaystoreordertfg!.sumsubtotal.toString()) / 1.15),style: userText.copyWith(color: Colors.white,fontSize: 11),)
                        ],
                      ),
                    ),
                  ),
                  giveWidth(10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                      decoration: BoxDecoration(
                          color: AppColors.primaryClr,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        children: [
                          Text("STAFF ORDERS",style: textHeading.copyWith(color: Colors.white,fontSize: 9,fontWeight: FontWeight.w400),),
                          giveHeight(2),
                          Text(tfgMoneyModel!.success!.todaystoreordertfg!.cnt.toString(),style: userText.copyWith(color: Colors.white,fontSize: 11),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              giveHeight(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                      decoration: BoxDecoration(
                          color: AppColors.primaryClr,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        children: [
                          Text("STORE SALES",style: textHeading.copyWith(color: Colors.white,fontSize: 9,fontWeight: FontWeight.w400),),
                          giveHeight(2),
                          Text(formatter.format(double.parse(tfgMoneyModel!.success!.todaycollectstoreordertfg!.sumsubtotal.toString()) / 1.15),style: userText.copyWith(color: Colors.white,fontSize: 11),)
                        ],
                      ),
                    ),
                  ),
                  giveWidth(10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                      decoration: BoxDecoration(
                          color: AppColors.primaryClr,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        children: [
                          Text("STORE ORDERS",style: textHeading.copyWith(color: Colors.white,fontSize: 9,fontWeight: FontWeight.w400),),
                          giveHeight(2),
                          Text(tfgMoneyModel!.success!.todaycollectstoreordertfg!.cnt.toString(),style: userText.copyWith(color: Colors.white,fontSize: 11),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25)),
    );
  }
}
