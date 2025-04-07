
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';
import 'package:volpes/store%20pages/quiz_component/common_button.dart';
import '../controllers/main_controller.dart';
import '../controllers/stores_controller.dart';
import '../resources/common_textfields.dart';
import '../resources/helpers.dart';

class VmSectionPage extends StatefulWidget {
  const VmSectionPage({super.key});

  @override
  State<VmSectionPage> createState() => _VmSectionPageState();
}

class _VmSectionPageState extends State<VmSectionPage> {
  final StoreController storeController = Get.put(StoreController());
  final mainController = Get.put(MainHomeController());
  final descController = TextEditingController();
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
                                // convertImageToBase64(File(mainController.image.value.path));
                                // convertBase64ToFile();
                              }
                              print("Camera: ${mainController.vmSectionImage.value}");
                              // print("Camera base64 : ${mainController.base64Value.value}");
                              Navigator.pop(context);

                            });
                          },
                          child: Icon(Icons.camera_alt_rounded,size: 45,color: AppColors.primaryClr,)),


                      GestureDetector(
                          onTap: (){
                            NewHelpers().addFilePicker().then((value){
                              if(value != null){
                                mainController.vmSectionImage.value = value;
                              }
                              print("Camera: ${mainController.vmSectionImage.value}");
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

    final key1= GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
              child: Form(
                key: key1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx((){
                      return
                        GestureDetector(
                          onTap: (){
                            showUploadWindow(context);
                          },
                          child: Center(
                            child: DottedBorder(
                              color:Colors.grey.shade300,
                              strokeWidth: 1,
                              dashPattern: [6, 3],
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              child: Container(
                                  width: width,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  alignment: Alignment.center,
                                  child:
                                  mainController.vmSectionImage.value.path != "" ?
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      mainController.vmSectionImage.value,
                                      fit: BoxFit.cover,
                                      height: height,
                                      width: width,
                                    ),
                                  ):
                                  Image.asset(
                                    "assets/images/upload.png",
                                    color: Colors.grey,
                                  )),
                            ),
                          ),
                        );
                    }),
                    giveHeight(10),
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
                    Align(
                        alignment: Alignment.center,
                        child: buttonCommon1(title: "UPLOAD", onTapp: (){
                          if(key1.currentState!.validate()){

                          }
                        }, context: context)),

                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    storeController.getData();
    // getStoresList();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                height: height * .28,
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
                    giveHeight(5),
                    //
                    // Text(
                    //   storeListData.desciption.toString().toUpperCase(),
                    //   style: textHeading.copyWith(
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 8,
                    //   ),
                    // ),
                    // giveHeight(2),
                    // Text(
                    //   forMatedDate,
                    //   style: textHeading.copyWith(
                    //     color: Colors.grey,
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: 9,
                    //   ),
                    // ),
                    giveHeight(4),
                    CachedNetworkImage(
                      imageUrl: ImgUrl.toString(),
                      fit: BoxFit.fitWidth,
                      height: height * .20,
                      width: width,
                      errorWidget: (_, __, ___) => Image.asset(
                        "assets/images/splash.png",
                        fit: BoxFit.fitWidth,
                        height: height * .20,
                        width: width,
                      ),
                      placeholder: (_, __) => Image.asset(
                        "assets/images/splash.png",
                        fit: BoxFit.fitWidth,
                        height: height * .20,
                        width: width,
                      ),
                    ),
                    giveHeight(6),
                    RichText(text: TextSpan(children:
                    [
                      TextSpan(text: "Description: ",  style: textHeading.copyWith(
                        color: AppColors.titleClr,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),),
                      TextSpan(text: storeListData.title.toString().toUpperCase(),
                      style: textHeading.copyWith(
                      color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),),
                    ])),
                    giveHeight(4),
                    RichText(text: TextSpan(children:
                    [
                      TextSpan(text: "Comment: ",  style: textHeading.copyWith(
                        color: AppColors.titleClr,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),),
                      TextSpan(text: storeListData.title.toString().toUpperCase(),
                      style: textHeading.copyWith(
                      color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),),
                    ])),

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
