import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/drawer_menu/shop-Section/cart_page.dart';
import 'package:volpes/models/product_detail_model.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/store%20pages/quiz_component/common_button.dart';
import '../../Resources/app_colors.dart';
import '../../repositories/save_quiz_repo.dart';
import '../../resources/height_width.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductData productData;
  const ProductDetailsPage({super.key, required this.productData});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  RxDouble sliderIndex = (0.0).obs;
  RxString variationPrice = "".obs;
  RxString variationSalePrice = "".obs;
  int productQty = 1;
  String productInventory = "";
  bool isOutOfStock = false;

  String productVariantId = "";
  increaseCount(){
    productQty++;
    setState(() {});
  }
  decreaseCount(){
    if(productQty > 1){
      productQty--;
    }

    setState(() {});
  }
  List<ProductVariation> productVariations = [];
  ProductVariation? selectedVariation;

  @override
  void initState() {
    super.initState();
    productVariations = widget.productData.productVariation ?? [];
    isOutOfStock = widget.productData.stockdetail == "outstockproduct";
    if (selectedVariation == null && productVariations.isNotEmpty) {
      selectedVariation = productVariations.firstWhere(
            (variation) => variation.varsku == widget.productData.productcode,

        orElse: () => productVariations[0],
      );
      productInventory = selectedVariation!.inventory.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryClr,
        elevation: 1,
        title: Row(
          children: [
            GestureDetector(
              onTap: (){
                Get.back();
                Get.back();
              },
              child: Image.asset(
                "assets/images/left-arrow.png",
                height: 22,
                width: 22,
                color: Colors.white,
              ),
            ),
            giveWidth(10),
            Text(
              widget.productData.breadcrumb![1].title.toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            giveHeight(10),
            CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (value, _) {
                    sliderIndex.value = value.toDouble();
                  },
                  autoPlayCurve: Curves.ease,
                  height: height * .20),
              items: List.generate(
                  widget.productData.productImages!.length,
                      (index){
                    final pathUrl = widget.productData.productImages![index].path;
                    final imgUrl = widget.productData.productImages![index].imagename;
                      final imgList = "${pathUrl.toString()}${imgUrl.toString()}";
                      log(imgList);
                    return Container(
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade200),
                            color: Colors.transparent),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: imgList,
                            errorWidget: (_, __, ___) =>
                            const SizedBox(),
                            placeholder: (_, __) =>
                            const SizedBox(),
                            fit: BoxFit.cover,
                          ),
                        ));
                      }
                          ),
            ),
            giveHeight(10),
            Text(widget.productData.productname.toString(),style: textHeading.copyWith(fontSize: 15,color: AppColors.primaryClr),),
            giveHeight(5),
           RichText(text: TextSpan(
             children: [
               TextSpan(text: "SKU: ",style: textHeading.copyWith(color: AppColors.titleClr,fontSize: 12)),
               TextSpan(text: widget.productData.productcode.toString(),style: textHeading.copyWith(color: AppColors.titleClr,fontSize: 11))
             ]
           )),
           giveHeight(5),
            variationPrice.value == "" ?
            Text(widget.productData.actPrice.toString(),style: userText.copyWith(fontSize: 13,color: Colors.black87),):
            Row(
              children: [
                Text("R${variationPrice.value.toString()}",style: userText.copyWith(fontSize: 13,color: Colors.red,decoration: TextDecoration.lineThrough,),),
               giveWidth(5),
                if(variationSalePrice.value != "0")
                Text("R${variationSalePrice.value.toString()}",style: userText.copyWith(fontSize: 13,color: Colors.black87),),
              ],
            ),
           giveHeight(10),
            CustomDropdown<ProductVariation>(
              hintText: 'SELECT OPTION',
              items: productVariations,
               initialItem: selectedVariation,
              excludeSelected: false,
              decoration: CustomDropdownDecoration(
                closedBorder: Border.all(color: Colors.black26),
                closedBorderRadius: BorderRadius.circular(5),
                expandedBorder: Border.all(color: Colors.black26),
                expandedBorderRadius: BorderRadius.circular(5),
                expandedFillColor: Colors.white,
                headerStyle: TextStyle(color: AppColors.primaryClr, fontSize: 13),
                listItemStyle: TextStyle(color: AppColors.primaryClr, fontSize: 13, fontWeight: FontWeight.w400),
                hintStyle: TextStyle(
                  color: AppColors.primaryClr,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                listItemDecoration: ListItemDecoration(selectedColor: Colors.grey.shade200)
              ),
              onChanged: (value) {
                setState(() {
                  selectedVariation = value;
                  productQty = 1;
                  variationPrice.value = selectedVariation!.price.toString();
                  variationSalePrice.value = selectedVariation!.saleprice.toString();
                  productVariantId = selectedVariation!.productvariantId.toString();
                  productInventory = selectedVariation!.inventory.toString();
                  isOutOfStock = (int.tryParse(productInventory ?? '') ?? 0) <= 0;
                  log("VARIATION PRODUCT INVENTORY: ${productInventory}");
                  log("VARIATION PRODUCT is in stock ?: ${isOutOfStock}");
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a variation';
                }
                return null;
              },
              headerBuilder: (context, selectedItem, enabled) => Container(
                padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                // height: height*.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey.shade200)
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          alignment: Alignment.center,
                          imageUrl: selectedItem.image.toString(),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => SizedBox(width: 40, height: 40),
                          errorWidget: (_, __, ___) => Icon(Icons.broken_image, size: 40),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(text: TextSpan(
                                  children: [
                                    TextSpan(text: "${selectedItem.attributeterm!.termname.toString().toUpperCase()} ",style: userText.copyWith(fontSize: 10)),
                                    TextSpan(
                                      text: selectedItem.stockdetail == "instockproduct"
                                          ? "INSTOCKPRODUCT"
                                          : selectedItem.stockdetail == "outstockproduct"
                                          ? "OUTOFSTOCK"
                                          : "UNKNOWN",
                                      style: userText.copyWith(
                                        fontSize: 10,
                                        color: selectedItem.stockdetail == "instockproduct"
                                            ? Colors.green
                                            : selectedItem.stockdetail == "outstockproduct"
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    )
                                  ]
                              )),
                              Row(
                                children: [
                                  Text("R${selectedItem.price}",style: userText.copyWith(fontSize: 10,decoration: TextDecoration.lineThrough,color: Colors.red)),
                                  giveWidth(5),
                                  if(selectedItem.saleprice != "0")
                                    Text("R${selectedItem.saleprice}",style: userText.copyWith(fontSize: 10,)),
                                ],
                              ),
                              giveHeight(2),
                              if(selectedItem.sizeline1 != "")
                              Text(selectedItem.sizeline1.toString(), style: userText.copyWith(fontSize: 9)),
                              Text("SKU: ${selectedItem.varsku.toString()}", style: userText.copyWith(fontSize: 10)),

                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),


              listItemBuilder: (context, item, isSelected, onItemSelect) {
                final imageUrl = item.image ?? '';
                return InkWell(
                  onTap: onItemSelect,
                  child:
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                    // height: height*.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade200)
                    ),
                    child: Column(
                      children: [
                        Row(
                           children: [
                            CachedNetworkImage(
                              alignment: Alignment.center,
                              imageUrl: imageUrl,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => SizedBox(width: 40, height: 40),
                              errorWidget: (_, __, ___) => Icon(Icons.broken_image, size: 40),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "${item.attributeterm!.termname.toString().toUpperCase()} ",style: userText.copyWith(fontSize: 10)),
                                        TextSpan(
                                          text: item.stockdetail == "instockproduct"
                                              ? "INSTOCKPRODUCT"
                                              : item.stockdetail == "outstockproduct"
                                              ? "OUTOFSTOCK"
                                              : "UNKNOWN",
                                          style: userText.copyWith(
                                            fontSize: 10,
                                            color: item.stockdetail == "instockproduct"
                                                ? Colors.green
                                                : item.stockdetail == "outstockproduct"
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        )
                                      ]
                                  )),
                                  Row(
                                    children: [
                                      Text("R${item.price}",style: userText.copyWith(fontSize: 10,decoration: TextDecoration.lineThrough,color: Colors.red)),
                                     giveWidth(5),
                                      if(item.saleprice != "0")
                                      Text("R${item.saleprice}",style: userText.copyWith(fontSize: 10,)),
                                    ],
                                  ),
                                  if(item.sizeline1 != "")
                                  Text(item.sizeline1.toString(), style: userText.copyWith(fontSize: 9)),
                                  Text("SKU: ${item.varsku.toString()}", style: userText.copyWith(fontSize: 10)),

                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),



          ],
        ),
      ),
      bottomNavigationBar:
      isOutOfStock ? null:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
        child: Row(

          children: [
           Expanded(
             child: Row(
               children: [
                 GestureDetector(
                   onTap: (){
                     decreaseCount();
                   },
                   child: Container(
                     padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         color: AppColors.primaryClr
                     ),
                     child: Icon(Icons.remove,color: Colors.white,),
                   ),
                 ),
                 giveWidth(10),
                 Text(productQty.toString(),style: userText,),
                 giveWidth(10),
                 GestureDetector(
                     onTap: (){
                       final maxInventory = int.tryParse(productInventory ?? '');

                       if (maxInventory != null && productQty < maxInventory) {
                         increaseCount();
                         log("HELLO ${maxInventory.toString()}");
                       } else {
                         showSnackBarView(
                           context: context,
                           msg: "Reached max count",
                           bgColor: Colors.red,
                         );
                       }


                     },
                   child: Container(
                     padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         color: AppColors.primaryClr
                     ),
                     child: Icon(Icons.add,color: Colors.white,),
                   ),
                 ),
               ],
             ),
           ),
            buttonCommon1(title: "ADD",
                onTapp: (){
              if(int.parse(productInventory) <= 0){
                showSnackBarView(context: context, msg: "Product is Out of stock", bgColor: Colors.red);
                print("OUT OF STOCK");
              }else{
                addToCartRepo(
                    qty: productQty.toString(),
                    productVariantId: productVariantId,
                    productId: widget.productData.productId.toString(),
                    context: context).then((value){
                  if(value.success != null){
                    Get.to(()=>CartPage());
                  }
                });

              }


            }, context: context)
          ],
        ),
      ),
    );
  }

}
