import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/resources/custom_loader.dart';

import '../../Resources/app_colors.dart';
import '../../common_repository/common_api_method.dart';
import '../../controllers/stores_controller.dart';
import '../../models/notification_detail_model.dart';
import '../../resources/api_urls.dart';
import '../../resources/common_texts_style.dart';
import '../../resources/height_width.dart';

class NotificationDetailScreen extends StatefulWidget {
  final String notiId;
  const NotificationDetailScreen({super.key, required this.notiId});

  @override
  State<NotificationDetailScreen> createState() => _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  final notiController = Get.put(StoreController());
  Repositories repositories = Repositories();
  NotificationDetailModel? notificationDetailModel;
  getNotiDetails({required String id}) {
    repositories
        .getApi(url: "${ApiUrls.getNotificationDetail}/${widget.notiId}")
        .then((value) {
      notificationDetailModel =
          NotificationDetailModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getNotiDetails(id: widget.notiId);
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryClr,
        elevation: 1,
        title: Row(
          children: [
            GestureDetector(
              onTap: (){
                notiController.getNotificationList();
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
              "Notification",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body:
          notificationDetailModel != null ?
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset("assets/images/app_icon.png",width: 75,)),
              giveHeight(20),
              Center(
                child: Text(
                    notificationDetailModel!.notifications!.titletext
                        .toString().capitalizeFirst.toString(),
                    textAlign: TextAlign.center,
                    style: userText.copyWith(fontSize: 18)),
              ),
              giveHeight(2),
              Center(
                child: Text(
                    notificationDetailModel!.notifications!.bodytext
                        .toString(),
                    textAlign: TextAlign.center,
                    style: textHeading.copyWith(fontSize: 12)),
              ),
              giveHeight(5),
              if(notificationDetailModel!.notifications!.image != null &&
                  notificationDetailModel!
                      .notifications!.image!.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: notificationDetailModel!.notifications!.image.toString(),
                  fit: BoxFit.contain,
                  // height: height,
                  width: width,
                  errorWidget: (_, __, ___) =>SizedBox(),
                  // errorWidget: (_, __, ___) => const SizedBox(),
                  placeholder: (_, __) => const SizedBox(),
                )

            ],
          ),
        ),
      ):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25),),
    );
  }
}
