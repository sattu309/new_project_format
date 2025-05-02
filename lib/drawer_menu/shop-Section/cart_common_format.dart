import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Resources/app_colors.dart';
import '../../controllers/cart_controller.dart';
import '../../repositories/add_to_cart_repo.dart';
import '../../resources/common_texts_style.dart';
import '../../resources/height_width.dart';
import 'cart_model.dart';

Stack cartFormat(String img, Products cartData, String salePrice, BuildContext context) {
  final cartController = Get.put(CartController());

  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 5),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              border:
              Border.all(color: Colors.grey.shade200)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                alignment: Alignment.center,
                imageUrl: img,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    SizedBox(width: 40, height: 40),
                errorWidget: (_, __, ___) =>
                    Icon(Icons.broken_image, size: 40),
              ),
              giveWidth(10),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                              cartData.productname.toString(),
                              style: userText.copyWith(
                                  fontSize: 11),
                            )),
                      ],
                    ),
                    giveHeight(2),
                    (double.parse(salePrice) <= 0) ?
                    Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "PRICE: ",
                                  style: userText.copyWith(
                                      fontSize: 9)),
                              TextSpan(
                                  text:
                                  "  R${cartData.price.toString()}",
                                  style: textHeading.copyWith(
                                      color: Colors.black54,
                                      fontSize: 10)),
                            ])),
                      ],
                    ):
                    Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "PRICE: ",
                                  style: userText.copyWith(
                                      fontSize: 9)),
                              TextSpan(
                                  text:
                                  "R${cartData.price.toString()}  ",
                                  style: textHeading.copyWith(
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 10)),
                              TextSpan(
                                  text:
                                  "  R${cartData.saleprice.toString()}",
                                  style: textHeading.copyWith(
                                      color: Colors.black54,
                                      fontSize: 10)),
                            ])),
                      ],
                    ),
                    giveHeight(5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.grey.shade300)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              updateCartRepo(
                                qty: (cartData.qty! - 1)
                                    .toString(),
                                productVariantId: cartData
                                    .productvariantId
                                    .toString(),
                                productId: cartData
                                    .productId
                                    .toString(),
                                context: context,
                              ).then((value) {
                                cartController.getData();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.only(
                                      topLeft: Radius
                                          .circular(4),
                                      bottomLeft: Radius
                                          .circular(4)),
                                  color:
                                  Colors.grey.shade300),
                              child: Icon(Icons.remove,
                                  color: Colors.black87,
                                  size: 15),
                            ),
                          ),
                          giveWidth(8),
                          Text(
                            cartData.qty.toString(),
                            style: userText.copyWith(
                                fontSize: 10),
                          ),
                          giveWidth(8),
                          GestureDetector(
                            onTap: () {
                              updateCartRepo(
                                qty: (cartData.qty! + 1)
                                    .toString(),
                                productVariantId: cartData
                                    .productvariantId
                                    .toString(),
                                productId: cartData
                                    .productId
                                    .toString(),
                                context: context,
                              ).then((value) {
                                cartController.getData();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.only(
                                      topRight: Radius
                                          .circular(4),
                                      bottomRight:
                                      Radius
                                          .circular(
                                          4)),
                                  color:
                                  Colors.grey.shade300),
                              child: Icon(
                                Icons.add,
                                color: Colors.black87,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Positioned(
          right: 25,
          top: 20,
          child: GestureDetector(
            onTap: (){

              updateCartRepo(
                qty: 0.toString(),
                productVariantId: cartData
                    .productvariantId
                    .toString(),
                productId: cartData
                    .productId
                    .toString(),
                context: context,
              ).then((value) {
                cartController.getData();
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryClr,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ImageIcon(
                  AssetImage("assets/images/delete.png"),
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ))
    ],
  );
}
