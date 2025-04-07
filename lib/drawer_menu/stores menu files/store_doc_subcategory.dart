import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';

import '../../common_repository/common_api_method.dart';
import '../../models/store_document_list.dart';
import '../../resources/api_urls.dart';

class StoreSubCategoryDocumentsScreen extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  const StoreSubCategoryDocumentsScreen({super.key, required this.categoryName, required this.categoryId});

  @override
  State<StoreSubCategoryDocumentsScreen> createState() => _StoreSubCategoryDocumentsScreenState();
}

class _StoreSubCategoryDocumentsScreenState extends State<StoreSubCategoryDocumentsScreen> {
  DocumentsListModel? documentsListModel;
  Repositories repository = Repositories();
  getStoresDocumentList(){
    repository.getApi(url: "${ApiUrls.getStoreDocumentsList}/${widget.categoryId}").then((value){
      documentsListModel = DocumentsListModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  void openPdf({required String pdfUrl}) async {
    Uri url = Uri.parse(pdfUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch $pdfUrl");
    }
  }
  @override
  void initState() {
    super.initState();
    getStoresDocumentList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customerAppBar(context, widget.categoryName),
      body:
      documentsListModel != null ?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            documentsListModel!.success!.doccats!.isNotEmpty ?
            Text("Documents Category",style: textHeading.copyWith(fontSize: 14,color: AppColors.titleClr),):SizedBox(),
            giveHeight(10),
            GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: documentsListModel!.success!.doccats!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisExtent: 115,
                    mainAxisSpacing: 10.0),
                itemBuilder: (context, index) {
                  final docData = documentsListModel!.success!.doccats![index];
                  final pdfLink = "${documentsListModel!.success!.documentlink.toString()}${docData.iconimage.toString()}";
                  final imgUrl = "${documentsListModel!.success!.documentlink.toString()}${docData.iconimage.toString()}";
                  return GestureDetector(
                    onTap: () {
                      print("PDF LINK ${pdfLink}");
                      openPdf(pdfUrl: pdfLink);
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
                                    imageUrl: imgUrl.toString(),
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
                                docData.category.toString(),
                                // maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.titleClr,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        )),
                  );
                }),
            documentsListModel!.success!.documents!.isNotEmpty ?
            Text("Documents",style: textHeading.copyWith(fontSize: 14,color: AppColors.titleClr),):SizedBox(),
            giveHeight(10),

            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: documentsListModel!.success!.documents!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisExtent: 120,
                      mainAxisSpacing: 10.0),
                  itemBuilder: (context, index) {
                    final docData = documentsListModel!.success!.documents![index];
                    final pdfLink = "${documentsListModel!.success!.documentlink.toString()}${docData.documentname.toString()}";
                    return GestureDetector(
                      onTap: () {
                        print("PDF LINK ${pdfLink}");
                        openPdf(pdfUrl: pdfLink);
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: documentsListModel!.success!.pdficon.toString(),
                                    errorWidget: (_, __, ___) => const SizedBox(),
                                    placeholder: (_, __) => const SizedBox(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              giveHeight(6),
                              Expanded(
                                child: Text(
                                  docData.title.toString(),
                                  // maxLines: 2,
                                  // overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.titleClr,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          )),
                    );
                  }),
            ),
          ],
        ),
      ):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25),),
    );
  }
}
