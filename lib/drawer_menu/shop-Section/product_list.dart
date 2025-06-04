import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/drawer_menu/shop-Section/product_details_page.dart';
import 'package:volpes/drawer_menu/shop-Section/product_list_model.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';

import '../../common_repository/common_api_method.dart';
import '../../repositories/save_quiz_repo.dart';
import '../../resources/api_urls.dart';

class ProductList extends StatefulWidget {
  final String productSlug;
  final String categoryLable;
  const ProductList({super.key, required this.productSlug, required this.categoryLable});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Repositories repositories = Repositories();
  ProductListModel? productListModel;
  getProductListData(){
    repositories.getApi(url: "${ApiUrls.prodouctListUrl}/${widget.productSlug}").then((value){
      productListModel = ProductListModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getProductListData();
  }
  @override
  Widget build(BuildContext context) {
    if (productListModel == null ||
        productListModel!.success == null ||
        productListModel!.success!.products == null) {
      return Scaffold(
        appBar: customerAppBar(context, widget.categoryLable),
        body: Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 30)),
      );
    }
    final filteredProducts = productListModel!.success!.products!
        .where((product) => (product.inventory != null  &&  product.inventory! > 0))
        .toList();

    return Scaffold(

      appBar: customerAppBar(context, widget.categoryLable),
      body:
          productListModel != null ? (productListModel!.success!.products!.isNotEmpty == true)?
          GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: filteredProducts.length,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 35.0,
                  mainAxisExtent: MediaQuery.of(context).size.height * 0.22,
                  // mainAxisExtent: 180,
                  mainAxisSpacing: 50.0),
              itemBuilder: (BuildContext context, index){
                final productData = filteredProducts[index];

            return
              buildGestureDetector(productData, context);
          }):Center(child: Text("No Product Found",style: userText,),):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 30),)

    );
  }

  GestureDetector buildGestureDetector(Products productData, BuildContext context) {
    return GestureDetector(
              onTap: (){
                getProductDetails(productId: productData.productId.toString(), context: context).then((value){
                  if(value.success != null){
                    Get.to(() => ProductDetailsPage(
                      productData: value.success!.productData!,
                    ));
                  }
                });
              },
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child:
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        alignment: Alignment.center,
                        imageUrl: productData.image.toString(),
                        width: 95,
                        height: 95,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Icon(Icons.broken_image, size: 40),
                        errorWidget: (_, __, ___) => Icon(Icons.broken_image, size: 40),
                      ),
                      giveHeight(7),
                      Text(productData.productname.toString(),textAlign:TextAlign.center,maxLines: 1,style: userText.copyWith(fontSize: 9,fontWeight: FontWeight.w400),),
                      giveHeight(3),
                      Text(productData.subtext != null ? productData.subtext.toString().toUpperCase():"",textAlign:TextAlign.center,style: userText.copyWith(fontSize: 10),),
                      giveHeight(5),
                      Divider(height: 10, thickness: 3,color: Colors.grey.shade200),
                      giveHeight(5),
                      if(productData.actPrice!.isNotEmpty)
                      Expanded(child: Text("${productData.actPrice.toString()}",textAlign:TextAlign.center,style: userText.copyWith(fontSize: 12,color: Colors.red,decoration: TextDecoration.lineThrough),)),
                      // giveHeight(2),
                      Expanded(child: Text("${productData.dispPrice.toString()}",textAlign:TextAlign.center,style: userText.copyWith(fontSize: 12,color: AppColors.primaryClr),)),

                    ],
                  ),
                  if(productData.badgetext!.isNotEmpty)
                  Positioned(
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 3),
                        decoration: BoxDecoration(
                          color: productData.badgetextbg != null
                              ? Color(int.parse('0xff${productData.badgetextbg!.replaceAll('#', '')}'))
                              : null,
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: Text(productData.badgetext!.toUpperCase().toString(),style: userText.copyWith(color: productData.badgetextcolor != null
                            ? Color(int.parse('0xff${productData.badgetextcolor!.replaceAll('#', '')}'))
                            : Colors.white,fontWeight: FontWeight.w400,fontSize: 10),),
                      )),
                  if(productData.badge != null && productData.badge!.isNotEmpty)
                    Positioned(
                        right: MediaQuery.of(context).size.width * 0.02, // 2% from right
                        bottom: MediaQuery.of(context).size.height * 0.1, // 10% from bottom
                        child: Image.network(productData.badge.toString(),height: MediaQuery.of(context).size.height * 0.035,)
                    )
                ],
              ),
                          ),
            );
  }
}
