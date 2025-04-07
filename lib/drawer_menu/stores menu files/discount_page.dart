import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volpes/resources/custom_loader.dart';

import '../../Resources/app_colors.dart';
import '../../common_repository/common_api_method.dart';
import '../../models/store_discount_model.dart';
import '../../resources/api_urls.dart';
import '../../resources/common_texts_style.dart';
import '../../resources/height_width.dart';
import '../admin menu files/common_appbar_drawer.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  Repositories repositories = Repositories();
  StoreDiscountModel? storeDiscountModel;
  getStoreDiscountList(){
    repositories.getApi(url: ApiUrls.getStoreDiscountList).then((value){
      storeDiscountModel = StoreDiscountModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getStoreDiscountList();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: customerAppBar(context,"Discounts"),
      body:

      storeDiscountModel != null ?
          ListView.builder(
              itemCount: storeDiscountModel!.success!.promodata!.length,
              itemBuilder: (BuildContext context,index){
                final discountData = storeDiscountModel!.success!.promodata![index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade50),

                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.10),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                      width:width,

                      decoration: BoxDecoration(
                          color:AppColors.primaryClr,
                          border: Border(
                            left: BorderSide(color: AppColors.primaryClr),
                            right: BorderSide(color: AppColors.primaryClr),
                          ),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(3),topLeft:Radius.circular(3) )
                      ),

                      child: Text(discountData.title.toString(),style: textHeading.copyWith(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 11),)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("APPLY TO",style: textHeading.copyWith(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 10),),
                        giveHeight(3),
                        Text(discountData.applyon.toString(),style: textHeading.copyWith(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 9),),

                      ],
                    ),
                  )
                ],
              ),
            );
          }):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25),)

    );
  }
}
