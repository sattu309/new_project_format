import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/drawer_menu/stores%20menu%20files/stores_document_screen.dart';

import '../../Resources/app_colors.dart';
import '../../common_repository/common_api_method.dart';
import '../../models/admin_menu_category_list.dart';
import '../../resources/api_urls.dart';
import '../../resources/common_texts_style.dart';
import '../../resources/custom_loader.dart';
import '../../resources/height_width.dart';

class StoreMenusList extends StatefulWidget {
  const StoreMenusList({super.key});

  @override
  State<StoreMenusList> createState() => _StoreMenusListState();
}

class _StoreMenusListState extends State<StoreMenusList> {
  Repositories repositories = Repositories();
  GetAdminMenuCategoryList? getAdminMenuCategoryList;
  getAdminMenuList(){
    repositories.getApi(url: ApiUrls.adminMenuList).then((value){
      getAdminMenuCategoryList = GetAdminMenuCategoryList.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getAdminMenuList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customerAppBar(context, "Documents"),
      body:
      getAdminMenuCategoryList != null ?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: getAdminMenuCategoryList!.success!.doccats!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisExtent: 140,
                    mainAxisSpacing: 10.0),
                itemBuilder: (context, index) {
                  final data = getAdminMenuCategoryList!.success!.doccats![index];
                  final ImgUrl = "${getAdminMenuCategoryList!.success!.documentlink}${data.iconimage.toString()}";
                  return GestureDetector(
                    onTap: () {
                              Get.to(()=>StoreDocumentsScreen(categoryName: data.category.toString(), categoryId: data.id.toString(),));

                    },
                    child: Container(
                      //height: 100,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryClr,
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: ImgUrl.toString(),
                                    errorWidget: (_, __, ___) => const SizedBox(),
                                    placeholder: (_, __) => const SizedBox(),
                                    fit: BoxFit.contain,

                                  ),
                                ),
                              ),
                            ),
                            giveHeight(6),
                            Expanded(
                              child: Text(
                                data.category.toString(),
                                // maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.titleClr,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        )),
                  );
                }),
          ],
        ),
      ):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25),),
    );
  }
}
