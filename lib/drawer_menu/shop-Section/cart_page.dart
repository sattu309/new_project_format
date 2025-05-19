
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/height_width.dart';

import '../../controllers/cart_controller.dart';
import '../../store pages/quiz_component/common_button.dart';
import 'cart_common_format.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController.getData();
    });
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
                      final img = imgPath + imgUrl;
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
                                "R${cartController.cartTotal.toStringAsFixed(2)}",
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
}
