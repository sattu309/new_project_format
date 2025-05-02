import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/custom_loader.dart';

import '../../common_repository/common_api_method.dart';
import '../../controllers/stores_controller.dart';
import '../../models/notification_detail_model.dart';
import '../../resources/api_urls.dart';
import '../../resources/height_width.dart';
import 'notification_detail_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  final notiController = Get.put(StoreController());
  Repositories repositories = Repositories();
  NotificationDetailModel? notificationDetailModel;
  getNotiDetails({required String id}) {
    repositories
        .getApi(url: "${ApiUrls.getNotificationDetail}/$id")
        .then((value) {
      notificationDetailModel =
          NotificationDetailModel.fromJson(jsonDecode(value));
      buildShowDialog(context);
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    notiController.getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: Obx(() {
          if (notiController.isDataLoading.value) {
            return Center(
                child:
                    threeArchedCircle(color: AppColors.primaryClr, size: 25));
          }
          if (notiController.notificationModel.value.notifications == null || notiController.notificationModel.value.notifications!.isEmpty ) {
            return Center(child: Text("No Notification Available",style: userText,));
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * .005),
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: notiController
                          .notificationModel.value.notifications!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final notiData = notiController
                            .notificationModel.value.notifications![index];
                        String formatedDate = DateFormat('MMM dd, yyyy').format(
                            DateTime.parse(notiData.createdAt.toString()));

                        return GestureDetector(
                          onTap: () {
                            Get.to(()=>NotificationDetailScreen(notiId: notiData.id.toString(),));

                          },
                          child: notificationList(
                              "By ${notiData.name.toString().capitalizeFirst} on ${formatedDate}",
                              notiData.titletext.toString().capitalizeFirst,
                              notiData.status.toString()),
                        );
                      }),
                ],
              ),
            ),
          );
        }));
  }

  Future<dynamic> buildShowDialog(
    BuildContext context,
  ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        builder: (context) {
          var img = notificationDetailModel!.notifications!.image.toString();

          return Dialog(
            child:
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset("assets/images/zone_logo.png",color: AppColors.primaryClr,width: 150,)),
                  giveHeight(10),
                  Text(
                      notificationDetailModel!.notifications!.titletext
                          .toString().capitalizeFirst.toString(),
                      style: userText.copyWith(fontSize: 15)),
                  giveHeight(1),
                  Text(
                      notificationDetailModel!.notifications!.bodytext
                          .toString(),
                      style: textHeading.copyWith(fontSize: 12)),
                  giveHeight(5),
                  if(notificationDetailModel!.notifications!.image != null &&
                          notificationDetailModel!
                              .notifications!.image!.isNotEmpty)
                       CachedNetworkImage(
                          imageUrl: img,
                          fit: BoxFit.fitWidth,
                          height: height * .20,
                          width: width,
                         errorWidget: (_, __, ___) => Image.asset(
                           "assets/images/splash.png",
                           fit: BoxFit.fitWidth,
                           height: height * .20,
                           width: width,
                         ),
                          // errorWidget: (_, __, ___) => const SizedBox(),
                          placeholder: (_, __) => const SizedBox(),
                        )

                ],
              ),
            ),
          );
        });
  }

  Widget notificationList(date, title, seenStatus) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      // margin: const EdgeInsets.only(left: 5, right: 5),
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Card(
        elevation: 0,
        child: Row(
          children: [
            SizedBox(
              width: width * 0.03,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 8, 8, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    giveHeight(6),
                    Text(title,
                        style: userText.copyWith(
                          fontSize: seenStatus == "0" ? 15 : 13,
                            fontWeight: seenStatus == "0" ?  FontWeight.bold: FontWeight.w400,
                            color: seenStatus == "0"
                                ? Color(0xff000000)
                                : Colors.grey)),
                    giveHeight(4),
                    Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                    giveHeight(4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
