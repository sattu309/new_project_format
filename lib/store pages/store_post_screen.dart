import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';
import '../common_repository/common_api_method.dart';
import '../controllers/stores_controller.dart';
import '../models/stores_list.dart';
import '../resources/api_urls.dart';

class StorePostScreen extends StatefulWidget {
  const StorePostScreen({super.key});

  @override
  State<StorePostScreen> createState() => _StorePostScreenState();
}

class _StorePostScreenState extends State<StorePostScreen> {
  final StoreController storeController = Get.put(StoreController());

  @override
  void initState() {
    super.initState();
    storeController.getData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body:
      Obx(() {
        if (storeController.isDataLoading.value) {
          return Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25));
        }
        if (storeController.model.value.success!.documents == null) {
          return Center(child: Text("No Stores Available"));
        }
        return RefreshIndicator(
          onRefresh: () async {
            await storeController.getData();
          },
          child: ListView.builder(
            itemCount: storeController.model.value.success!.documents!.length,
            itemBuilder: (BuildContext context, index) {
              final storeListData = storeController.model.value.success!.documents![index];
              final forMatedDate = DateFormat('dd MMM yyyy').format(DateTime.parse(storeListData.createdAt.toString()));
              final ImgUrl = "${storeController.model.value.success!.documentlink!}${storeListData.imagepath.toString()}";

              print("STORE IMAGES ${ImgUrl.toString()}");

              return Container(
                height: height * .3,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    giveHeight(10),
                    Text(
                      storeListData.title.toString().toUpperCase(),
                      style: textHeading.copyWith(
                        color: AppColors.primaryClr,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      storeListData.desciption.toString().toUpperCase(),
                      style: textHeading.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 8,
                      ),
                    ),
                    giveHeight(2),
                    Text(
                      forMatedDate,
                      style: textHeading.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 9,
                      ),
                    ),
                    giveHeight(4),
                    GestureDetector(
                      onTap: (){
                        showImageViewer(
                          context,
                          Image.network(ImgUrl).image,
                          useSafeArea: false,
                          swipeDismissible: true,
                          doubleTapZoomable: true,
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: ImgUrl.toString(),
                        fit: BoxFit.fitWidth,
                        height: height * .20,
                        width: width,
                        errorWidget: (_, __, ___) => Image.asset(
                          "assets/images/placeHolder.png",
                          fit: BoxFit.fitWidth,
                          height: height * .20,
                          width: width,
                        ),
                        placeholder: (_, __) => Image.asset(
                          "assets/images/placeHolder.png",
                          fit: BoxFit.fitWidth,
                          height: height * .20,
                          width: width,
                        ),
                      ),
                    ),
                    giveHeight(6),
                    Text(
                      storeListData.storename.toString(),
                      style: textHeading.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );

      }),
    );
  }
}
