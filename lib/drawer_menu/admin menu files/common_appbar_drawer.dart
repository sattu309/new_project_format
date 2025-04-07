import 'package:flutter/material.dart';

import '../../Resources/app_colors.dart';
import '../../resources/height_width.dart';

AppBar customerAppBar(BuildContext context,  title) {
  // final mainController = Get.put(MainHomeController());
  return
    AppBar(
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
            title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.white),
        ),
      ],
    ),

    // actions: [
    //   mainController.currentIndex.value == 2 ?
    //   Padding(
    //     padding: const EdgeInsets.all(12.0),
    //     child: InkWell(
    //         onTap: (){
    //
    //           Get.to(()=>AddStorePost());
    //         },
    //         child: Icon(Icons.add,size: 25,)),
    //   ):SizedBox()
    // ],
  );
}