
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volpes/drawer_menu/user_drawer.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:volpes/resources/methods.dart';
import 'package:volpes/store%20pages/appbar_method.dart';
import 'package:volpes/store%20pages/store_post_screen.dart';
import 'package:volpes/store%20pages/take_quiz_screen.dart';
import 'controllers/main_controller.dart';
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          storeAppBar(context: context,title: "Welcome Volpes K90"):
          controller.currentIndex.value == 1 ? storeAppBar(context: context, title: "Quiz"):
          controller.currentIndex.value == 2 ? storeAppBar(context: context, title: "Store Post"):
          storeAppBar(context: context, title: "Catalogue"),
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
                              label: 'STORE POSTS'),
                           BottomNavigationBarItem(
                              icon: InkWell(
                                onTap: (){
                                  openPdf(pdfUrl: "https://joom.ag/9FMd");
                                },
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 03,
                                    ),
                                    child: ImageIcon(AssetImage("assets/images/catalogue.png"),size: 18,)),
                              ),
                              label: 'CATALOGUE'),

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
                  StoreHomepage(),
                ],
              );
            }),
          ));
    });


  }
}
