
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/drawer_menu/stores%20menu%20files/video_player_widget.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';
import 'package:volpes/store%20pages/quiz_component/common_button.dart';
import '../../controllers/main_controller.dart';
import '../../controllers/stores_controller.dart';
import '../../repositories/add_store_post_repo.dart';
import '../../resources/common_textfields.dart';
import '../../resources/helpers.dart';

class VmSectionPage extends StatefulWidget {
  const VmSectionPage({super.key});

  @override
  State<VmSectionPage> createState() => _VmSectionPageState();
}

class _VmSectionPageState extends State<VmSectionPage> {
  final StoreController storeController = Get.put(StoreController());
  final mainController = Get.put(MainHomeController());
  final descController = TextEditingController();
  final titleController = TextEditingController();
  showUploadWindow(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child:

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      GestureDetector(
                          onTap: (){
                            NewHelpers().takeImgFromCamera().then((value){
                              if(value != null){
                                mainController.vmSectionImage.value = value;
                                mainController.vmSectionReplyImg.value = value;
                                mainController.vmSectionImageType.value = 'image';
                                  }
                              print("Camera: ${mainController.vmSectionImage.value}");
                              Navigator.pop(context);

                            });
                          },
                          child: Icon(Icons.camera_alt_rounded,size: 45,color: AppColors.primaryClr,)),


                      GestureDetector(
                        onTap: () {
                          NewHelpers().addFilePickerVedio().then((result) {
                            if (result != null) {
                              File file = result['file'];
                              String type = result['type'];

                              // You can store both file and type, or just file
                              mainController.vmSectionImage.value = file;
                              mainController.vmSectionReplyImg.value = file;
                              mainController.vmSectionImageType.value = type; // Optional if you want to check later

                              print("Selected $type file: ${file.path}");
                            }
                            Navigator.pop(context);
                          });
                        },

                        child: Icon(Icons.image_sharp,size: 45,color: AppColors.primaryClr,)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),

            ),
          ),
        );
      },
    );
  }
  showAlertBox() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final isLoading = false.obs;

    final key1= GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
              child: SingleChildScrollView(
                child: Form(
                  key: key1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      giveHeight(5),
                      Obx(() {
                        final file = mainController.vmSectionImage.value;
                        final type = mainController.vmSectionImageType.value;

                        return GestureDetector(
                          onTap: () {
                            showUploadWindow(context);
                          },
                          child:
                          Center(
                            child: DottedBorder(
                              color: Colors.grey.shade300,
                              strokeWidth: 1,
                              dashPattern: [6, 3],
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              child: Container(
                                width: width,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child:
                                mainController.vmSectionImage.value.path != ""
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: type == 'image'
                                      ? Image.file(
                                    file,
                                    fit: BoxFit.cover,
                                    height: height,
                                    width: width,
                                  )
                                      : SizedBox(
                                    width: width,
                                    height: height,
                                    child: VideoPlayerWidget(file: file), // ensure file is video
                                  ),
                                )
                                    : Image.asset(
                                  "assets/images/upload.png",
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),

                      giveHeight(10),
                      Text("Title",style: textHeading,),
                      giveHeight(3),
                      CustomTextField(
                        controller: titleController,
                        hint: "Description",
                        validator: MultiValidator([
                          RequiredValidator(errorText: ' '),
                        ]).call,
                      ),
                      giveHeight(5),
                      Text("Description",style: textHeading,),
                      giveHeight(3),
                      CustomTextField(
                        controller: descController,
                        hint: "Description",
                        validator: MultiValidator([
                          RequiredValidator(errorText: ' '),
                        ]).call,
                      ),
                      giveHeight(20),
                      Obx(() => isLoading.value
                          ?  Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25))
                          : Align(
                        alignment: Alignment.center,
                        child: buttonCommon1(
                          title: "UPLOAD",
                          onTapp: () {
                            if (key1.currentState!.validate()) {
                              isLoading.value = true; // Start loader

                              Map<String, String> mapData = {
                                'title': titleController.text,
                                'desciption': descController.text,
                              };

                              vmSectionUploadRepo(
                                context: context,
                                mapData: mapData,
                                fieldName1: "imagepath",
                                file1: mainController.vmSectionImage.value,
                              ).then((value) {
                                isLoading.value = false; // Stop loader

                                if (value.success != null) {
                                  storeController.getVmSectionList();
                                  mainController.vmSectionImage.value = File("");
                                  titleController.clear();
                                  descController.clear();
                                  Navigator.pop(context);
                                }
                              });
                            }
                          },
                          context: context,
                        ),
                      ))


                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      storeController.getVmSectionList();
    });

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar:AppBar(
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
              "VM Section",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.all(14.0),
            child: InkWell(
                onTap: (){

                  showAlertBox();
      },
                child: Icon(Icons.add,size: 25,)),
          )
        ],
      ),
      body:
      Obx(() {
        if (storeController.isDataLoading.value) {
          return Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25));
        }
        if (storeController.vmSectionListModel.value.success!.documents == null || storeController.vmSectionListModel.value.success!.documents!.isEmpty) {
          return Center(child: Text("No VM Post Available",style: userText,));
        }
        return RefreshIndicator(
          onRefresh: () async {
            await storeController.getVmSectionList();
          },
          child: ListView.builder(
            itemCount: storeController.vmSectionListModel.value.success!.documents!.length,
            itemBuilder: (BuildContext context, index) {
              final storeListData = storeController.vmSectionListModel.value.success!.documents![index];
              final ImgUrl = "${storeController.vmSectionListModel.value.success!.documentlink!}/${storeListData.imagepath.toString()}";
                  print("VM Images ${ImgUrl}");

              return Container(
                // height: height ,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(0),
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
                    // Text(type,style: userText,),
                    giveHeight(4),


                    GestureDetector(
                      onTap: (){
                        if(storeListData.uploadtype == "Video"){
                          showDialog(context: context, builder: (context){
                            return Dialog(
                              child: SizedBox(
                                  height: 300,
                                  width: width,
                                  child: VideoPlayerWidget(networkUrl: ImgUrl,)),
                            );
                          });

                        }else{
                          showImageViewer(
                            context,
                            Image.network(ImgUrl).image,
                            useSafeArea: false,
                            swipeDismissible: true,
                            doubleTapZoomable: true,
                          );
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: storeListData.uploadtype == "Video"
                            ? SizedBox(
                          height: height * .20,
                          width: width,
                          child: VideoPlayerWidget(file: File(ImgUrl),networkUrl: ImgUrl,), // use the URL here
                        )
                            : CachedNetworkImage(
                          imageUrl: ImgUrl,
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
                    ),
                    giveHeight(6),
                    Text(storeListData.title.toString().toUpperCase(),
                      style: userText.copyWith(fontSize: 11),),
                    RichText(text: TextSpan(children:
                    [
                      TextSpan(text: "",  style: textHeading.copyWith(
                        color: AppColors.titleClr,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),),
                      TextSpan(text: storeListData.desciption.toString().toUpperCase(),
                      style: userText.copyWith(fontSize: 9,color: Colors.black54, fontWeight: FontWeight.w400,),),
                    ])),
                    giveHeight(4),
                    if(storeListData.comments != null && storeListData.comments!.isNotEmpty)
                      // ExpansionTile(
                      //   minTileHeight: 20,
                      //   tilePadding: EdgeInsets.zero,
                      //   initiallyExpanded: false,
                      //   iconColor: AppColors.primaryClr,
                      //   title: Text(
                      //     "Comments (${storeListData.totcomments.toString()})",
                      //     style: userText.copyWith(fontSize: 10),
                      //   ),
                      //   children: List.generate(
                      //     storeListData.comments!.length,
                      //         (index1) {
                      //       final commentData = storeListData.comments![index1];
                      //       String formatedDate = DateFormat('MMM dd, yyyy')
                      //           .format(DateTime.parse(commentData.createdAt.toString()));
                      //
                      //       return Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               "By ${commentData.name.toString().capitalizeFirst} on $formatedDate",
                      //               style: const TextStyle(
                      //                 fontWeight: FontWeight.w400,
                      //                 color: Colors.black,
                      //                 fontSize: 9,
                      //               ),
                      //             ),
                      //             giveHeight(3),
                      //             Row(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Expanded(
                      //                   child: Text(
                      //                     commentData.comments.toString(),
                      //                     style: textHeading.copyWith(
                      //                       color: const Color(0xff555555),
                      //                       fontWeight: FontWeight.w400,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             giveHeight(5),
                      //             if (index1 != 0) const Divider(height: 1, color: Colors.grey),                                  giveHeight(3 ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        showTrailingIcon: false,
                        initiallyExpanded: false,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Comments (${storeListData.totcomments.toString()})",
                              style: userText.copyWith(fontSize: 10),
                            ),
                             Icon(Icons.comment, size: 14, color: AppColors.primaryClr),
                          ],
                        ),
                        children: [
                          SizedBox(
                            // adjust as needed
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(), // because ExpansionTile already scrolls
                              itemCount: storeListData.comments!.length,
                              separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey),
                              itemBuilder: (context, index1) {
                                final commentData = storeListData.comments![index1];
                                String formatedDate = DateFormat('MMM dd, yyyy').format(
                                    DateTime.parse(commentData.createdAt.toString()));

                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "By ${commentData.name.toString().capitalizeFirst} on $formatedDate",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 9,
                                        ),
                                      ),
                                      giveHeight(3),
                                      Text(
                                        commentData.comments.toString(),
                                        style: textHeading.copyWith(
                                          color: const Color(0xff555555),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      giveHeight(5),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),


                    giveHeight(5),
                    GestureDetector(
                      onTap: (){
                        replyBox(
                            parentId: storeListData.id.toString(),
                            title: storeListData.title.toString());
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("reply".toUpperCase(),
                          textAlign: TextAlign.right,
                          style: textHeading.copyWith(
                          color: AppColors.primaryClr,
                          fontWeight: FontWeight.w600,
                        ),),
                      ),
                    ),
                    giveHeight(5),
                    ...List.generate(
                        storeListData.reply!.length, (index2){
                      final rplydata = storeListData.reply![index2];
                      final rplyImgUrl = "${storeController.vmSectionListModel.value.success!.documentlink!}/${rplydata.imagepath.toString()}";

                      String formatedDate = DateFormat('MMM dd, yyyy').format(
                          DateTime.parse(rplydata.createdAt.toString()));
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                          ),
                          giveHeight(3),
                          Text(
                            "ON ${formatedDate}",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 9,
                            ),
                          ),
                          giveHeight(3),
                          GestureDetector(
                            onTap: (){
                              if(rplydata.uploadtype == "Video"){
                                showDialog(context: context, builder: (context){
                                  return Dialog(
                                    child: SizedBox(
                                        height: 300,
                                        width: width,
                                        child: VideoPlayerWidget(networkUrl: ImgUrl,)),
                                  );
                                });

                              }else{
                                showImageViewer(
                                  context,
                                  Image.network(rplyImgUrl).image,
                                  useSafeArea: false,
                                  swipeDismissible: true,
                                  doubleTapZoomable: true,
                                );
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: storeListData.uploadtype == "Video"
                                  ? SizedBox(
                                height: height * .20,
                                width: width,
                                child: VideoPlayerWidget(file: File(rplyImgUrl),networkUrl: rplyImgUrl,), // use the URL here
                              )
                                  : CachedNetworkImage(
                                imageUrl: rplyImgUrl,
                                fit: BoxFit.fitWidth,
                                height: height * .15,
                                width: width * .70,
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
                          ),
                          giveHeight(5),
                        ],
                      );
                    }),

                  ],
                ),
              );
            },
          ),
        );

      }),
    );
  }
  replyBox({required String parentId,required String title}) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final isLoading = false.obs;

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    giveHeight(5),
                    Text(title,style: userText,),
                    giveHeight(7),
                    Obx(() {
                      final file = mainController.vmSectionReplyImg.value;
                      final type = mainController.vmSectionImageType.value;

                      return GestureDetector(
                        onTap: () {
                          showUploadWindow(context);
                        },
                        child:
                        Center(
                          child: DottedBorder(
                            color: Colors.grey.shade300,
                            strokeWidth: 1,
                            dashPattern: [6, 3],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(10),
                            child: Container(
                              width: width,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child:
                              mainController.vmSectionImage.value.path != ""
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: type == 'image'
                                    ? Image.file(
                                  file,
                                  fit: BoxFit.cover,
                                  height: height,
                                  width: width,
                                )
                                    : SizedBox(
                                  width: width,
                                  height: height,
                                  child: VideoPlayerWidget(file: file), // ensure file is video
                                ),
                              )
                                  : Image.asset(
                                "assets/images/upload.png",
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    giveHeight(20),
                    Obx(() => isLoading.value
                        ?  Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25))
                        : Align(
                      alignment: Alignment.center,
                      child: buttonCommon1(
                        title: "REPLY",
                        onTapp: () {
                            isLoading.value = true; // Start loader

                            Map<String, String> mapData = {
                              'parent_id':parentId,
                              'title': "",
                              'desciption': "",
                            };

                            vmSectionUploadRepo(
                              context: context,
                              mapData: mapData,
                              fieldName1: "imagepath",
                              file1: mainController.vmSectionReplyImg.value,
                            ).then((value) {
                              isLoading.value = false; // Stop loader

                              if (value.success != null) {
                                storeController.getVmSectionList();
                                mainController.vmSectionReplyImg.value = File("");
                                Navigator.pop(context);
                              }
                            });
                        },
                        context: context,
                      ),
                    ))


                  ],
                ),
              ),
            ),
          );
        });
  }
}
