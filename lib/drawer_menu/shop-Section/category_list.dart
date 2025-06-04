import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/common_repository/common_api_method.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/drawer_menu/shop-Section/product_list.dart';
import 'package:volpes/resources/api_urls.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';
import 'category_list_model.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  Repositories repositories = Repositories();
  CategoryListModel? categoryListModel;
    getCategoryListData(){
      repositories.getApi(url: ApiUrls.categoryListUrl).then((value){
        categoryListModel = CategoryListModel.fromJson(jsonDecode(value));
        setState(() {});
      });
    }
    @override
  void initState() {
    super.initState();
    getCategoryListData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customerAppBar(context, "Shop by Category"),
      body:
      categoryListModel != null ?
      SingleChildScrollView(
        child: Column(
          children: [
            giveHeight(10),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categoryListModel!.success!.navItems!.length,
              itemBuilder: (BuildContext context, index) {
                final cateLable = categoryListModel!.success!.navItems![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            collapsedBackgroundColor: cateLable.bgColor != null
                                ? Color(int.parse('0xff${cateLable.bgColor!.replaceAll('#', '')}'))
                                : null,
                              backgroundColor: cateLable.bgColor != null
                                  ? Color(int.parse('0xff${cateLable.bgColor!.replaceAll('#', '')}'))
                                  : null,

                            tilePadding: EdgeInsets.zero,
                            showTrailingIcon: (cateLable.subItems != null && cateLable.subItems!.isNotEmpty),
                            minTileHeight: 35,
                            childrenPadding: EdgeInsets.zero,
                            iconColor: AppColors.titleClr,
                            title: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: GestureDetector(
                                onTap: (){
                                  Get.to(() => ProductList(productSlug: cateLable.slug.toString(),categoryLable: cateLable.label.toString()));

                                },
                                child: Text(
                                  cateLable.label.toString(),
                                  style: userText.copyWith(
                                    color: cateLable.color != null
                                        ? Color(int.parse('0xff${cateLable.color!.replaceAll('#', '')}'))
                                        : const Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                            children: cateLable.subItems != null
                                ? List.generate(cateLable.subItems!.length, (index1) {
                              final subCatLab = cateLable.subItems![index1];
                              final labelText = subCatLab.label ?? "";
                              final labelAllText = subCatLab.labelAll ?? "";

                              if (subCatLab.subItems1 != null && subCatLab.subItems1!.isNotEmpty) {
                                return Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 40, top: 3, bottom: 3),
                                      child: Divider(height: 0, color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: ExpansionTile(
                                        minTileHeight: 35,
                                        iconColor: AppColors.titleClr,
                                        title: Text(
                                          labelText,
                                          style:  TextStyle(
                                            color: AppColors.titleClr,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        children: List.generate(subCatLab.subItems1!.length, (index2) {
                                          final subItem1 = subCatLab.subItems1![index2];
                                          final subItem1Label = subItem1.label ?? subItem1.labelAll ?? "No Label";

                                          if (subItem1.subItems2 != null && subItem1.subItems2!.isNotEmpty) {
                                            return Padding(
                                              padding: const EdgeInsets.only(left: 20.0),
                                              child: ExpansionTile(
                                                minTileHeight: 35,
                                                iconColor: AppColors.titleClr,
                                                title: Text(
                                                  subItem1Label,
                                                  style:  TextStyle(
                                                    color: AppColors.titleClr,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                children: List.generate(subItem1.subItems2!.length, (index3) {
                                                  final subItem2 = subItem1.subItems2![index3];
                                                  final subItem2Label = subItem2.label ?? subItem2.labelAll ?? "No Label";
                                                  return _nestedDrawerTile(
                                                    "",
                                                    subItem2Label,
                                                    index3,
                                                    onTap: () {
                                                      print(subItem2.slug.toString());
                                                      Get.to(() => ProductList(productSlug: subItem2.slug.toString(),categoryLable: subItem2Label));
                                                    },
                                                  );
                                                }),
                                              ),
                                            );
                                          } else {
                                            return _nestedDrawerTile("", subItem1Label, index2,   onTap: () {
                                              print(subItem1.slug.toString());
                                              Get.to(() => ProductList(productSlug: subItem1.slug.toString(), categoryLable: subItem1.labelAll ?? subItem1.label.toString(),));
                                            },);
                                          }
                                        }),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return _nestedDrawerTile(labelText, labelAllText, index1,   onTap: () {
                                  print(subCatLab.slug.toString());
                                  Get.to(() => ProductList(productSlug: subCatLab.slug.toString(),categoryLable: subCatLab.labelAll ?? subCatLab.label.toString()));
                                },);
                              }
                            })
                                : [],
                          ),
                        ),
                      ),
                      cateLable.bgColor != null ? const SizedBox() : const Divider(height: 0, color: Colors.grey),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      )
          :Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 30),),
    );
  }
  Widget _nestedDrawerTile(String titleHead, String title, int index, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 5, bottom: 5),
      child: InkWell(
        onTap:onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 0, color: Colors.grey),
            const SizedBox(height: 8),
            if (titleHead.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(titleHead, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.titleClr)),
              ),
            if (title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.titleClr)),
              ),
          ],
        ),
      ),
    );
  }

// Widget _nestedDrawerTile(String titleHead, String title,  int index) {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 40, top: 5, bottom: 7),
  //
  //     child: InkWell(
  //       // onTap:onTap,
  //       borderRadius: BorderRadius.circular(8),
  //       child: Column(
  //         children: [
  //           const Divider(
  //             height: 0,
  //             color: Colors.grey,
  //           ),
  //           giveHeight(3),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 7),
  //             child: Row(children: [
  //               Expanded(
  //                 child: Text(
  //                   title,
  //                   style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.titleClr,),
  //                 ),
  //               ),
  //             ],
  //             ),
  //           ),
  //
  //
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
