import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Resources/app_colors.dart';
import '../controllers/main_controller.dart';
import '../resources/height_width.dart';
import 'add_store_post.dart';

AppBar storeAppBar({required BuildContext context, required String title}) {
  final mainController = Get.put(MainHomeController());
  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: AppColors.primaryClr,
    elevation: 1,
    centerTitle: false,
    title: Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(color: Colors.white),
    ),
    actions: [
      mainController.currentIndex.value == 2 ?
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
            onTap: (){

              Get.to(()=>AddStorePost());
            },
            child: Icon(Icons.add,size: 25,)),
      ):
      Padding(
        padding: const EdgeInsets.all(14.0),
        child: Image.asset(
          "assets/images/app_icon.png",
          height: 30,
          width: 30,
        ),
      ),
    ],
  );
}