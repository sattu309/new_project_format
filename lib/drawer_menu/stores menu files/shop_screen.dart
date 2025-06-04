import 'dart:convert';
import 'dart:developer';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/drawer_menu/shop-Section/cart_page.dart';
import 'package:volpes/resources/common_button.dart';
import 'package:volpes/resources/height_width.dart';

import '../../Resources/app_colors.dart';
import '../../repositories/save_quiz_repo.dart';
import '../shop-Section/category_list.dart';
import '../shop-Section/product_details_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String barcode = 'Tap  to scan';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryClr,
        elevation: 1,
        title: Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
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
              'Scanner',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
                onTap: (){
                  Get.to(()=>CartPage());
                },
                child: ImageIcon(AssetImage("assets/images/cart.png"),size: 26,color: Colors.white,)),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset("assets/images/barcode.png"),
              ),
              CommonAppButton(title: "SCAN", onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AiBarcodeScanner(
                      onDispose: () {
                        debugPrint("Barcode scanner disposed!");
                      },
                      hideGalleryButton: false,
                      controller: MobileScannerController(
                        detectionSpeed: DetectionSpeed.noDuplicates,
                      ),
                      onDetect: (BarcodeCapture capture) async {
                        final String? scannedValue = capture.barcodes.first.rawValue;
                        debugPrint("Barcode scanned: $scannedValue");

                        if (scannedValue != null && scannedValue.isNotEmpty) {
                          await searchProductRepo( productCode: scannedValue,context: context).then((value){
                            if (value.success != null) {
                              log("DATA: ${jsonEncode(value.success!.toJson())}");

                              Get.to(() => ProductDetailsPage(
                                productData: value.success!.productData!,
                              ));
                            }

                          });
                        }
                      },
                      validator: (value) {
                        return value.barcodes.isNotEmpty;
                      },
                    ),
                  ),
                );
              }, isArrow: false),
              giveHeight(10),
              CommonAppButton(title: "Shop by Category".toUpperCase(), onPressed: (){
                Get.to(()=>CategoryList());
              }, isArrow: false
              )
            ],
          ),
        ),
      ),
    );
  }
}