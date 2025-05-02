import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/common_repository/common_api_method.dart';
import 'package:volpes/resources/api_urls.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/user_details_controller.dart';
import '../models/dashboard_model.dart';
import '../resources/common_texts_style.dart';

class StoreHomepage extends StatefulWidget {
  const StoreHomepage({super.key});

  @override
  State<StoreHomepage> createState() => _StoreHomepageState();
}

class _StoreHomepageState extends State<StoreHomepage> {
  final userDetailsController = Get.put(UserDetailsController());
  Repositories repositories = Repositories();
  DashboradModel? dashboradModel;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  // DateTime? dateTime;
  getDashboardData(){
    repositories.getApi(url: ApiUrls.dashBoardUrl).then((value){
       dashboradModel = DashboradModel.fromJson(jsonDecode(value));
       // dateTime = DateTime.parse(dashboradModel!.success!.yearstartdate.toString());
      setState(() {});
    });
  }
  showAlertBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/app_icon.png",
                    height: 40,
                    width: 40,
                  ),
                  giveHeight(10),
                  Text(
                    "Are you sure want to logout ?",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  giveHeight(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryClr),
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                            // Perform logout action here
                            // logoutUser(context);
                          },
                          child: Text("Cancel",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "poppins")),
                        ),
                      ),
                      giveWidth(20),
                      SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryClr),
                          onPressed: () {
                            repositories.logOutUser();
                          },
                          child: Text("Logout",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "poppins")),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
  late final WebViewController _instaFeedController;
  @override
  void initState() {
    super.initState();
    userDetailsController.getUserDetails();
    getDashboardData();
    _instaFeedController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
        'https://cdn.lightwidget.com/widgets/e7c68283074c52eab0364d2b8c8dffe0.html',
      ));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body:
          dashboradModel != null ?
      SingleChildScrollView(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // userDetailsController.userRoles.value == "STORE" ? SizedBox():
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),              child: Image.asset(
                "assets/images/store_logoo.jpeg",
                fit: BoxFit.fitWidth,
                height: height * .24,
                width: width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "TODAY'S SALES ",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700)),
                        TextSpan(
                            text: "(EX. VAT)",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10)),
                      ])),
                  giveHeight(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title: "CIF'S (TODAY)",
                            data: dashboradModel!.success!.todaycif.toString(), icon: Icons.attach_money, width, clr: Colors.green),
                      ),
                     giveWidth(15),
                      Expanded(
                        child: buildContainer(title: "CIF'S (THIS MONTH)",
                            data: dashboradModel!.success!.monthcif.toString(), icon: Icons.attach_money, width, clr: Colors.green),
                      ),
                    ],
                  ),
                  giveHeight(15),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       child: buildContainer(title: "TOTAL SALES",data:  formatter.format(((double.tryParse(dashboradModel!.success!.todaystoreorder!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15 +
                  //           (double.tryParse(dashboradModel!.success!.todayretailorder!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)
                  //       ), icon: Icons.attach_money, width, clr: Colors.green),
                  //     ),
                  //    giveWidth(15),
                  //     Expanded(
                  //       child: buildContainer(title: "TOTAL ORDERS",
                  //           data:  (dashboradModel!.success!.todaystoreorder!.cnt + dashboradModel!.success!.todayretailorder!.cnt).toString(), icon: Icons.list_alt_rounded, width, clr: Colors.green),
                  //     ),
                  //   ],
                  // ),
                  // giveHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title:  "STORE SALES",data:

                        formatter.format(((double.tryParse(dashboradModel!.success!.todaystoreorder!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)),
                            icon: Icons.store, width, clr: Colors.transparent),
                      ),
                      giveWidth(15),
                      Expanded(
                        child: buildContainer(title:  "STORE ORDER",data:

                        dashboradModel!.success!.todaystoreorder!.cnt!.toString(),
                            icon: Icons.store, width, clr: Colors.transparent),
                      ),

                    ],
                  ),
                  giveHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title:  "TOTAL ORDERS (CURRENT MONTH)",data:

                        dashboradModel!.success!.mtdallorders!.cnt!.toString(),
                            icon: Icons.store, width, clr: Colors.transparent),
                      ),


                      giveWidth(15),
                      Expanded(
                        child: buildContainer(title:  "TOTAL SALES (CURRENT MONTH)",data:

                        formatter.format(((double.tryParse(dashboradModel!.success!.mtdallorders!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)),
                            icon: Icons.store, width, clr: Colors.transparent),
                      ),

                    ],
                  ),
                  giveHeight(15),

                  Text("TOP QUIZ MEMBER",style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
                  giveHeight(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title: "TODAY",data: "DEVOPS", icon: Icons.attach_money, width, clr: Colors.green),
                      ),
                      giveWidth(15),
                      Expanded(
                        child: buildContainer(title: "THIS MONTH",data: "TESTER", icon: Icons.attach_money, width, clr: Colors.green),
                      ),
                    ],
                  ),
                  giveHeight(7),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "#Volpes_sa",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600)
                  ),
                  giveHeight(4),
                  SizedBox(
                    height: 150,
                    child: WebViewWidget(controller: _instaFeedController),
                  ),
                ],
              ),
            )

          ],
        ),
      ):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25)),
    );
  }

  Container buildContainer(double width, {required String title, required String data, required IconData icon,required Color? clr}) {
    return Container(

                  padding:EdgeInsets.symmetric(horizontal: 10,vertical: 25),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                    transform: GradientRotation(90),
                        colors: [
                      Colors.white,
                      Color(0xffadc9e4)
                    ]),
                    color: Colors.white,

                    // border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, -15),
                        blurRadius: 20,
                        color: const Color(0xFFDADADA).withOpacity(0.15),
                      )
                    ],
                  ),

                 width: width*.44,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(title,style: textHeading.copyWith(fontSize: 9),),
                      giveHeight(2),
                      Text(data,style: userText,),
                      giveHeight(2),
                      // Icon(icon,size: 15,color: AppColors.primaryClr,),


                    ],
                  ),
                );
  }

  AppBar customerAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryClr,
      elevation: 1,
      title: Row(
        children: [
          Image.asset(
            "assets/images/app_icon.png",
            height: 30,
            width: 30,
          ),
          giveWidth(10),
          Text(
            "Welcome Testuser",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
              onTap: () {
                showAlertBox();
              },
              child: ImageIcon(
                AssetImage("assets/images/turn-off.png"),
                color: Colors.white,
              )),
        ),
      ],
    );
  }
  AppBar adminAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: AppColors.primaryClr,
      elevation: 1,
      title: Row(
        children: [
          // IconButton(color: Colors.white,  onPressed: () {
          //   Get.to(()=>UserDrawer());
          // }, icon: Icon(Icons.menu),),
          // giveWidth(10),
          Text(
            "DASHBOARD",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
