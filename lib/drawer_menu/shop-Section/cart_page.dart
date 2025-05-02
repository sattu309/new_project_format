import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:volpes/common_repository/common_api_method.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/resources/api_urls.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/height_width.dart';

import '../../controllers/cart_controller.dart';
import '../../repositories/add_to_cart_repo.dart';
import '../../repositories/start_quiz_repo.dart';
import '../../store pages/quiz_component/common_button.dart';
import 'cart_common_format.dart';
import 'cart_model.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    cartController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: customerAppBar(context, "MY CART"),
        body:
        Obx(() {
          if (cartController.isDataLoading.value) {
            Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryClr,
                ));
          }
          if (cartController.cartModel.value.success!.products!.isEmpty) {
            return Center(child: Text("Cart is Empty",style: userText,));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartController
                        .cartModel.value.success!.products!.length,
                    itemBuilder: (BuildContext context, index) {
                      final cartData = cartController
                          .cartModel.value.success!.products![index];
                      final imgPath = cartController
                          .cartModel.value.success!.imagepath
                          .toString();
                      final imgUrl = cartData.image.toString();
                      final img = "${imgPath + imgUrl}";
                      final price = cartData.price.toString();
                      final salePrice = cartData.saleprice.toString();
                      return
                        cartFormat(img, cartData, salePrice, context);
                    }),
              )
            ],
          );
        }),
        bottomNavigationBar: Obx(() {
          var products = cartController.cartModel.value.success?.products;
          if (products != null && products.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300)),
                          child: Column(
                            children: [
                              Text(
                                "TOTAL",
                                style: userText.copyWith(
                                    fontSize: 10, color: AppColors.primaryClr),
                              ),
                              Text(
                                "R${cartController.cartTotal.toString()}",
                                style: userText,
                              ),
                            ],
                          ),
                        ),
                      ),
                      giveWidth(10),
                      buttonCommon1(
                          title: "CHECKOUT",
                          onTapp: () {
                            Get.to(() => CheckoutPage());
                          },
                          context: context)
                    ],
                  )
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        }),


      );

  }

  // Stack cartFormat(String img, Products cartData, String salePrice, BuildContext context) {
  //   return Stack(
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(
  //                             horizontal: 16, vertical: 5),
  //                         child: Container(
  //                           padding: EdgeInsets.symmetric(
  //                               horizontal: 10, vertical: 10),
  //                           decoration: BoxDecoration(
  //                               border:
  //                                   Border.all(color: Colors.grey.shade200)),
  //                           child: Row(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               CachedNetworkImage(
  //                                 alignment: Alignment.center,
  //                                 imageUrl: img,
  //                                 width: 40,
  //                                 height: 40,
  //                                 fit: BoxFit.cover,
  //                                 placeholder: (_, __) =>
  //                                     SizedBox(width: 40, height: 40),
  //                                 errorWidget: (_, __, ___) =>
  //                                     Icon(Icons.broken_image, size: 40),
  //                               ),
  //                               giveWidth(10),
  //                               Expanded(
  //                                 child: Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Row(
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       children: [
  //                                         Expanded(
  //                                             child: Text(
  //                                           cartData.productname.toString(),
  //                                           style: userText.copyWith(
  //                                               fontSize: 11),
  //                                         )),
  //                                       ],
  //                                     ),
  //                                     giveHeight(2),
  //                                     (double.parse(salePrice) <= 0) ?
  //                                     Row(
  //                                       children: [
  //                                         RichText(
  //                                             text: TextSpan(children: [
  //                                           TextSpan(
  //                                               text: "PRICE: ",
  //                                               style: userText.copyWith(
  //                                                   fontSize: 9)),
  //                                           TextSpan(
  //                                               text:
  //                                                   "  R${cartData.price.toString()}",
  //                                               style: textHeading.copyWith(
  //                                                   color: Colors.black54,
  //                                                   fontSize: 10)),
  //                                         ])),
  //                                       ],
  //                                     ):
  //                                     Row(
  //                                       children: [
  //                                         RichText(
  //                                             text: TextSpan(children: [
  //                                           TextSpan(
  //                                               text: "PRICE: ",
  //                                               style: userText.copyWith(
  //                                                   fontSize: 9)),
  //                                           TextSpan(
  //                                               text:
  //                                                   "R${cartData.price.toString()}  ",
  //                                               style: textHeading.copyWith(
  //                                                   color: Colors.red,
  //                                                   decoration: TextDecoration.lineThrough,
  //                                                   fontSize: 10)),
  //                                           TextSpan(
  //                                               text:
  //                                                   "  R${cartData.saleprice.toString()}",
  //                                               style: textHeading.copyWith(
  //                                                   color: Colors.black54,
  //                                                   fontSize: 10)),
  //                                         ])),
  //                                       ],
  //                                     ),
  //                                     giveHeight(5),
  //                                     Container(
  //                                       decoration: BoxDecoration(
  //                                           borderRadius:
  //                                               BorderRadius.circular(5),
  //                                           border: Border.all(
  //                                               color: Colors.grey.shade300)),
  //                                       child: Row(
  //                                         mainAxisSize: MainAxisSize.min,
  //                                         children: [
  //                                           GestureDetector(
  //                                             onTap: () {
  //                                               updateCartRepo(
  //                                                 qty: (cartData.qty! - 1)
  //                                                     .toString(),
  //                                                 productVariantId: cartData
  //                                                     .productvariantId
  //                                                     .toString(),
  //                                                 productId: cartData
  //                                                     .productId
  //                                                     .toString(),
  //                                                 context: context,
  //                                               ).then((value) {
  //                                                 cartController.getData();
  //                                               });
  //                                             },
  //                                             child: Container(
  //                                               padding: EdgeInsets.symmetric(
  //                                                   horizontal: 4,
  //                                                   vertical: 3),
  //                                               decoration: BoxDecoration(
  //                                                   borderRadius:
  //                                                       BorderRadius.only(
  //                                                           topLeft: Radius
  //                                                               .circular(4),
  //                                                           bottomLeft: Radius
  //                                                               .circular(4)),
  //                                                   color:
  //                                                       Colors.grey.shade300),
  //                                               child: Icon(Icons.remove,
  //                                                   color: Colors.black87,
  //                                                   size: 15),
  //                                             ),
  //                                           ),
  //                                           giveWidth(8),
  //                                           Text(
  //                                             cartData.qty.toString(),
  //                                             style: userText.copyWith(
  //                                                 fontSize: 10),
  //                                           ),
  //                                           giveWidth(8),
  //                                           GestureDetector(
  //                                             onTap: () {
  //                                               updateCartRepo(
  //                                                 qty: (cartData.qty! + 1)
  //                                                     .toString(),
  //                                                 productVariantId: cartData
  //                                                     .productvariantId
  //                                                     .toString(),
  //                                                 productId: cartData
  //                                                     .productId
  //                                                     .toString(),
  //                                                 context: context,
  //                                               ).then((value) {
  //                                                 cartController.getData();
  //                                               });
  //                                             },
  //                                             child: Container(
  //                                               padding: EdgeInsets.symmetric(
  //                                                   horizontal: 4,
  //                                                   vertical: 3),
  //                                               decoration: BoxDecoration(
  //                                                   borderRadius:
  //                                                       BorderRadius.only(
  //                                                           topRight: Radius
  //                                                               .circular(4),
  //                                                           bottomRight:
  //                                                               Radius
  //                                                                   .circular(
  //                                                                       4)),
  //                                                   color:
  //                                                       Colors.grey.shade300),
  //                                               child: Icon(
  //                                                 Icons.add,
  //                                                 color: Colors.black87,
  //                                                 size: 15,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     )
  //                                   ],
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       Positioned(
  //                           right: 25,
  //                           top: 20,
  //                           child: GestureDetector(
  //                             onTap: (){
  //
  //                               updateCartRepo(
  //                                 qty: 0.toString(),
  //                                 productVariantId: cartData
  //                                     .productvariantId
  //                                     .toString(),
  //                                 productId: cartData
  //                                     .productId
  //                                     .toString(),
  //                                 context: context,
  //                               ).then((value) {
  //                                 cartController.getData();
  //                               });
  //                             },
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                 color: AppColors.primaryClr,
  //                                 borderRadius: BorderRadius.circular(5),
  //                               ),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.all(4.0),
  //                                 child: ImageIcon(
  //                                   AssetImage("assets/images/delete.png"),
  //                                   color: Colors.white,
  //                                   size: 14,
  //                                 ),
  //                               ),
  //                             ),
  //                           ))
  //                     ],
  //                   );
  // }
}
