import 'dart:convert';
import 'dart:developer';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/resources/common_button.dart';
import 'package:volpes/resources/common_texts_style.dart';

import '../../repositories/save_quiz_repo.dart';
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
      appBar: customerAppBar(context, "Scanner"),
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
              // ElevatedButton(
              //   child: const Text('Scan Barcode'),
              //   onPressed: () async {
              //     await Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => AiBarcodeScanner(
              //           onDispose: () {
              //             debugPrint("Barcode scanner disposed!");
              //           },
              //           hideGalleryButton: false,
              //           controller: MobileScannerController(
              //             detectionSpeed: DetectionSpeed.noDuplicates,
              //           ),
              //           onDetect: (BarcodeCapture capture) async {
              //             final String? scannedValue = capture.barcodes.first.rawValue;
              //             debugPrint("Barcode scanned: $scannedValue");
              //
              //             if (scannedValue != null && scannedValue.isNotEmpty) {
              //               await searchProductRepo( productCode: scannedValue,context: context).then((value){
              //                 if(value.success != null){
              //                   Get.offAll(()=>ProductDetailsPage());
              //                 }
              //               });
              //             }
              //           },
              //           validator: (value) {
              //             return value.barcodes.isNotEmpty;
              //           },
              //         ),
              //       ),
              //     );
              //   },
              // ),

            ],
          ),
        ),
      ),
    );
  }
}