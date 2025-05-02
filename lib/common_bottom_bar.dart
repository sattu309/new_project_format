
import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volpes/drawer_menu/stores%20menu%20files/notification_screen.dart';
import 'package:volpes/drawer_menu/user_drawer.dart';
import 'package:volpes/push_notification/notification_service.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:volpes/resources/methods.dart';
import 'package:volpes/store%20pages/appbar_method.dart';
import 'package:volpes/store%20pages/store_post_screen.dart';
import 'package:volpes/store%20pages/take_quiz_screen.dart';
import 'controllers/cart_controller.dart';
import 'controllers/main_controller.dart';
import 'controllers/stores_controller.dart';
import 'controllers/user_details_controller.dart';
import 'customer_dashboard/customer_homepage.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    Key? key,
  }) : super(key: key);
  static var customNavigationBar = "/customNavigationBar";

  @override
  CustomNavigationBarState createState() => CustomNavigationBarState();
}

class CustomNavigationBarState extends State<CustomNavigationBar> {
  final controller = Get.put(MainHomeController());
  final cartController = Get.put(CartController());
  final notiController= Get.put(StoreController());
  final userDetailsController = Get.put(UserDetailsController());
  manageNotification() async {
    print("function call");
    NotificationService().createNotificationChannel();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService().showNotification(message );
      print("Foreground message received: ${message.notification?.body}");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("App opened by notification: ${message.notification?.title}");
      print("App opened by notification: ${message.notification?.body}");
      if (userDetailsController.userRoles.value == "store") {
        controller.currentIndex.value = 3;
      }else{

      }
    });
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print("App opened from terminated state via notification");
        if (userDetailsController.userRoles.value == "store") {
          controller.currentIndex.value = 3;
        }else{

        }

      }
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    manageNotification();
    cartController.getData();
    cartController.getCHECKOUTData();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return
    Obx((){
      return Scaffold(
          key: controller.scaffoldKey,
          drawer: UserDrawer(),
          appBar:
          controller.currentIndex.value == 0 ?
          storeAppBar(context: context,title: "Welcome ${userDetailsController.userName.value}"):
          controller.currentIndex.value == 1 ? storeAppBar(context: context, title: "Quiz"):
          controller.currentIndex.value == 2 ? storeAppBar(context: context, title: "#LOVEMYSTORE"):
          storeAppBar(context: context, title: "Notifications"),
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Obx(() {
            return BottomAppBar(
                color: Colors.white,
                shape: const CircularNotchedRectangle(),
                clipBehavior: Clip.hardEdge,
                elevation: 0,
                child: Theme(
                    data: ThemeData(
                        splashColor: Colors.transparent,
                        bottomNavigationBarTheme:
                        BottomNavigationBarThemeData(
                            backgroundColor: AppColors.primaryClr,
                            elevation: 0)),
                    child: BottomNavigationBar(
                        unselectedLabelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 10, fontWeight: FontWeight.w300),
                        selectedLabelStyle:  TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                        items: [

                          const BottomNavigationBarItem(
                              icon: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 03,
                                  ),
                                  child: ImageIcon(AssetImage("assets/images/menu.png"),size: 18,)),
                              label: 'DASHBOARD'),
                          BottomNavigationBarItem(
                              icon: InkWell(
                                onTap: (){
                                  controller.onItemTap(1);
                                },
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 03,
                                    ),
                                    child: ImageIcon(AssetImage("assets/images/quiz.png"),size: 18,)),
                              ),
                              label: 'TAKE QUIZ'),
                          const BottomNavigationBarItem(
                              icon: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 03,
                                  ),
                                  child: ImageIcon(AssetImage("assets/images/shop.png"),size: 18,)),
                              label: '#LOVEMYSTORE'),

                          BottomNavigationBarItem(
                              icon: InkWell(
                                onTap: (){
                                  controller.onItemTap(3);
                                  notiController.getNotificationList();
                                },
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 03,
                                    ),
                                    child:
                                        Obx((){
                                          return  Badge(
                                              badgeStyle:  BadgeStyle(badgeColor: Colors.white,padding: EdgeInsets.symmetric(horizontal: 3,vertical: 3)),
                                              badgeContent:
                                              Text(notiController.notiCount.value,style:  TextStyle(color:AppColors.primaryClr,fontSize: 11),),
                                              child: ImageIcon(AssetImage("assets/images/notification.png"),size: 20,));
                                        })

                                ),
                              ),
                              label: 'NOTIFICATION'),

                        ],
                        type: BottomNavigationBarType.fixed,
                        currentIndex: controller.currentIndex.value,
                        selectedItemColor: Colors.white,
                        unselectedItemColor: Colors.white,
                        iconSize: 40,
                        onTap: controller.onItemTap,
                        elevation: 0)));
          }),
          body: Center(
            child: Obx(() {
              return IndexedStack(
                index: controller.currentIndex.value,
                children: const [
                  StoreHomepage(),
                  TakeQuizScreen(),
                  StorePostScreen(),
                  NotificationScreen(),
                ],
              );
            }),
          ));
    });


  }
}
