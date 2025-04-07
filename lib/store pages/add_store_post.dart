import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../Resources/app_colors.dart';
import '../controllers/main_controller.dart';
import '../controllers/stores_controller.dart';
import '../repositories/add_store_post_repo.dart';
import '../resources/common_textfields.dart';
import '../resources/height_width.dart';
import '../resources/helpers.dart';

class AddStorePost extends StatefulWidget {
  const AddStorePost({super.key});

  @override
  State<AddStorePost> createState() => _AddStorePostState();
}

class _AddStorePostState extends State<AddStorePost> {
  final StoreController storeController = Get.put(StoreController());
  final mainController = Get.put(MainHomeController());
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final fKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryClr,
        elevation: 1,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
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
              "Add Store Post",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: fKey,
          child:

                  Column(
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
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  alignment: Alignment.center,
                                  child:
                                  mainController.image.value.path != "" ?
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      mainController.image.value,
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
                    CustomTextField(
                      controller: titleController,
                      hint: "Title",
                      validator: MultiValidator([
                        RequiredValidator(errorText: ' '),
                      ]).call,
                    ),
                    giveHeight(10),
                    CustomTextField(
                      controller: descController,
                      hint: "Description",
                      validator: MultiValidator([
                        RequiredValidator(errorText: ' '),
                      ]).call,
                    ),
                    giveHeight(30),

                        SizedBox(
                        width: width,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryClr),
                            onPressed: () async {
                              if(fKey.currentState!.validate()){
                                Map<String, String> mapData = {
                                  'title': titleController.text,
                                  'desciption': descController.text,
                                };
                                addStorePostRepo(
                                    context: context,
                                    mapData: mapData,
                                    fieldName1: "imagepath",
                                    file1: mainController.image.value
                                ).then((value){
                                  if(value.success != null){
                                    storeController.getData();
                                    mainController.image.value = File("");
                                    Navigator.pop(context);
                                  }
                                });
                              }
                            },
                            child: Text(
                              "ADD",
                              style: TextStyle(
                                  letterSpacing: 1, fontWeight: FontWeight.w400),
                            )),
                      ),


                  ],
                ),


        ),
      ),
    );
  }
  Future<String> convertImageToBase64(File file) async {
    try {
      if (!file.existsSync()) {
        log("Error: File does not exist at ${file.path}");
        return "";
      }

      List<int> imageBytes = await file.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      String mimeType = file.path.endsWith(".png") ? "png" : "jpg";
      String finalBase64String = "data:image/$mimeType;base64,$base64Image";

     mainController.base64Value.value = File(finalBase64String);
      log("Encoded Image testing: ${mainController.base64Value.value}");
      return finalBase64String;
    } catch (e) {
      log("Error converting image: $e");
      return "";
    }
  }
  Future<File> convertBase64ToFile(String base64String, String fileName) async {
    try {
      // Extract only the Base64 part (remove `data:image/...;base64,`)
      String base64Data = base64String.split(',').last;

      // Decode the Base64 string into bytes
      Uint8List bytes = base64Decode(base64Data);

      // Get the temporary directory
      Directory tempDir = await getTemporaryDirectory();
      File file = File('${tempDir.path}/$fileName');

      // Write bytes to file
      await file.writeAsBytes(bytes);

      return file;
    } catch (e) {
      throw Exception("Error converting Base64 to File: $e");
    }
  }

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
                                          mainController.image.value = value;
                                          // convertImageToBase64(File(mainController.image.value.path));
                                            // convertBase64ToFile();
                                        }
                                        print("Camera: ${mainController.image.value}");
                                       // print("Camera base64 : ${mainController.base64Value.value}");
                                        Navigator.pop(context);

                                      });
                                    },
                                    child: Icon(Icons.camera_alt_rounded,size: 45,color: AppColors.primaryClr,)),


                              GestureDetector(
                                  onTap: (){
                                    NewHelpers().addFilePicker().then((value){
                                      if(value != null){
                                        mainController.image.value = value;
                                      }
                                      print("Camera: ${mainController.image.value}");
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
}
