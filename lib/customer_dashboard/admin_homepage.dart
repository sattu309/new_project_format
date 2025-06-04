import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/common_repository/common_api_method.dart';
import 'package:volpes/drawer_menu/user_drawer.dart';
import 'package:volpes/resources/api_urls.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';
import '../controllers/user_details_controller.dart';
import '../models/dashboard_model.dart';
import '../resources/common_texts_style.dart';


class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  final userDetailsController = Get.put(UserDetailsController());
  Repositories repositories = Repositories();
  DashboradModel? dashboradModel;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  getDashboardData(){
    repositories.getApi(url: ApiUrls.dashBoardUrl).then((value){
      dashboradModel = DashboradModel.fromJson(jsonDecode(value));
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
  @override
  void initState() {
    super.initState();
    userDetailsController.getUserDetails();
    getDashboardData();

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      drawer: UserDrawer(),
      appBar: adminAppBar(context),
      body:
      dashboradModel != null ?
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  giveHeight(7),
                  // RichText(
                  //     text: TextSpan(children: [
                  //       TextSpan(
                  //           text: "TODAY'S SALES ",
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .titleSmall
                  //               ?.copyWith(fontWeight: FontWeight.w700,fontSize: 15)),
                  //       TextSpan(
                  //           text: "(EX. VAT)",
                  //           style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12)),
                  //     ])),
                  // giveHeight(12),
                  Text("Stores:",style: userText,),
                  giveHeight(7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title:  "STORE TOTAL SALES (TODAY)",
                            data: formatter.format(((double.tryParse(dashboradModel!.success!.storesales.toString() ?? "0") ?? 0))),
                            icon: Icons.store, width, clr: Colors.transparent),
                      ),
                      giveWidth(15),
                      Expanded(
                        child: buildContainer(title:  "STORE TOTAL SALES (YESTERDAY)",
                            data: formatter.format(((double.tryParse(dashboradModel!.success!.storesalesyesterday.toString() ?? "0") ?? 0))),
                            icon: Icons.store, width, clr: Colors.transparent),
                      ),

                    ],
                  ),
                  giveHeight(15),
                  Text("E-Commerce:",style: userText,),
                  giveHeight(7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title: "TOTAL SALES",
                            data: formatter.format(((double.tryParse(dashboradModel!.success!.todaystoreorder!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15 +
                                (double.tryParse(dashboradModel!.success!.todayretailorder!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15 +
                                (double.tryParse(dashboradModel!.success!.todaycollectstoreorder!.sumsubtotal?.toString() ?? "0") ?? 0))
                            ), icon: Icons.attach_money, width, clr: Colors.green),
                      ),
                      giveWidth(15),
                      Expanded(
                        child: buildContainer(title: "TOTAL ORDERS",
                            data: (dashboradModel!.success!.todaystoreorder!.cnt + dashboradModel!.success!.todayretailorder!.cnt + dashboradModel!.success!.todaycollectstoreorder!.cnt).toString(), icon: Icons.attach_money, width, clr: Colors.green),
                      ),
                    ],
                  ),
                  giveHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title: "TOTAL AVERAGE ORDER VALUE",
                            data: formatter.format(double.tryParse(dashboradModel!.success!.avgordval.toString())), icon: Icons.attach_money, width, clr: Colors.green),
                      ),

                    ],
                  ),
                  giveHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title: "YEAR START FROM",
                            data: dashboradModel!.success!.yearstartdate.toString(), icon: Icons.attach_money, width, clr: Colors.green),
                      ),
                      giveWidth(15),
                      Expanded(
                        child: buildContainer(title: "MONTH START FROM",
                            data: dashboradModel!.success!.monthstartdate.toString(), icon: Icons.attach_money, width, clr: Colors.green),
                      ),

                    ],
                  ),
                  giveHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title: "RETAIL SALES",
                            data: formatter.format(((double.tryParse(dashboradModel!.success!.todayretailorder!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)), icon: Icons.attach_money, width, clr: Colors.green),
                      ),
                      giveWidth(15),
                      Expanded(
                        child: buildContainer(title: "RETAIL ORDERS",
                            data: dashboradModel!.success!.todayretailorder!.cnt!.toString(), icon: Icons.attach_money, width, clr: Colors.green),
                      ),

                    ],
                  ),
                  giveHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title: "STORE SALES",
                            data: formatter.format(((double.tryParse(dashboradModel!.success!.todaystoreorder!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)), icon: Icons.attach_money, width, clr: Colors.green),
                      ),
                      giveWidth(15),
                      Expanded(
                        child: buildContainer(title: "STORE ORDERS",
                            data: dashboradModel!.success!.todaystoreorder!.cnt!.toString(), icon: Icons.attach_money, width, clr: Colors.green),
                      ),

                    ],
                  ),
                  giveHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title: "YESTERDAYS RETAILS",
                            data: formatter.format(((double.tryParse(dashboradModel!.success!.yesterdayretailsales!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)), icon: Icons.attach_money, width, clr: Colors.green),
                      ),
                      giveWidth(15),
                      Expanded(
                        child: buildContainer(title: "YESTERDAYS ORDERS",
                            data: dashboradModel!.success!.yesterdayretailsales!.cnt!.toString(), icon: Icons.attach_money, width, clr: Colors.green),
                      ),

                    ],
                  ),
                  giveHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title: "SALES (THIS MONTH)",
                            data: formatter.format(((double.tryParse(dashboradModel!.success!.mtdallorders!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)), icon: Icons.attach_money, width, clr: Colors.green),
                      ),
                      giveWidth(15),
                      Expanded(
                        child: buildContainer(title: "TOTAL ORDERS (CURRENT MONTH)",
                            data: dashboradModel!.success!.mtdallorders!.cnt!.toString(), icon: Icons.attach_money, width, clr: Colors.green),
                      ),

                    ],
                  ),
                  giveHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title: "SALES (THIS YEAR)",
                            data: formatter.format(((double.tryParse(dashboradModel!.success!.ytdallorders!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)), icon: Icons.attach_money, width, clr: Colors.green),
                      ),
                      giveWidth(15),
                      Expanded(
                        child: buildContainer(title: "ORDERS (THIS YEAR)",
                            data: dashboradModel!.success!.ytdallorders!.cnt!.toString(), icon: Icons.attach_money, width, clr: Colors.green),
                      ),

                    ],
                  ),
                  giveHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildContainer(title: "SALES TO TARGET",
                            data: formatter.format(double.tryParse(dashboradModel!.success!.salestarget!.toString())), icon: Icons.attach_money, width, clr: Colors.green),
                      ),


                    ],
                  ),
                  giveHeight(15),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "TOTAL SALES",
                  //             style: textHeading.copyWith(fontSize: 13),
                  //           ),
                  //           giveHeight(3),
                  //           Text(
                  //               formatter.format(((double.tryParse(dashboradModel!.success!.todaystoreorder!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15 +
                  //                   (double.tryParse(dashboradModel!.success!.todayretailorder!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15 +
                  //                   (double.tryParse(dashboradModel!.success!.todaycollectstoreorder!.sumsubtotal?.toString() ?? "0") ?? 0))
                  //               ),style: userText.copyWith(fontSize: 14)
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text("TOTAL ORDERS", style: textHeading.copyWith(fontSize: 13)),
                  //           giveHeight(3),
                  //           Text((dashboradModel!.success!.todaystoreorder!.cnt + dashboradModel!.success!.todayretailorder!.cnt + dashboradModel!.success!.todaycollectstoreorder!.cnt).toString(), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // giveHeight(7),
                  // Divider(
                  //   height: 5,
                  //   color: Colors.black26,
                  // ),
                  // giveHeight(7),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "TOTAL AVERAGE ORDER VALUE",
                  //             style: textHeading.copyWith(fontSize: 13),
                  //           ),
                  //           giveHeight(3),
                  //           Text( formatter.format(double.tryParse(dashboradModel!.success!.avgordval.toString())), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // giveHeight(7),
                  // Divider(
                  //   height: 5,
                  //   color: Colors.black26,
                  // ),
                  // giveHeight(7),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "YEAR START FROM",
                  //             style: textHeading.copyWith(fontSize: 13),
                  //           ),
                  //           giveHeight(3),
                  //           Text(
                  //               dashboradModel!.success!.yearstartdate.toString(), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "MONTH START FROM",
                  //             style: textHeading.copyWith(fontSize: 13),
                  //           ),
                  //           giveHeight(3),
                  //           Text(dashboradModel!.success!.monthstartdate.toString(), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // giveHeight(7),
                  // Divider(
                  //   height: 5,
                  //   color: Colors.black26,
                  // ),
                  // giveHeight(7),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "RETAIL SALES",
                  //             style: textHeading.copyWith(fontSize: 13),
                  //           ),
                  //           giveHeight(3),
                  //           Text(formatter.format(((double.tryParse(dashboradModel!.success!.todayretailorder!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //               "RETAIL ORDERS", style: textHeading.copyWith(fontSize: 13)),
                  //           giveHeight(3),
                  //           Text(dashboradModel!.success!.todayretailorder!.cnt!.toString(), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // giveHeight(7),
                  //
                  // Divider(
                  //   height: 5,
                  //   color: Colors.black26,
                  // ),
                  // giveHeight(7),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "STORE SALES",
                  //             style: textHeading.copyWith(fontSize: 13),
                  //           ),
                  //           giveHeight(3),
                  //           Text(formatter.format(((double.tryParse(dashboradModel!.success!.todaystoreorder!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //               "STORE ORDERS", style: textHeading.copyWith(fontSize: 13)),
                  //           giveHeight(3),
                  //           Text(dashboradModel!.success!.todaystoreorder!.cnt!.toString(), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // giveHeight(7),
                  // Divider(
                  //   height: 5,
                  //   color: Colors.black26,
                  // ),
                  // giveHeight(7),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "YESTERDAYS RETAILS",
                  //             style: textHeading.copyWith(fontSize: 13),
                  //           ),
                  //           giveHeight(3),
                  //           Text(formatter.format(((double.tryParse(dashboradModel!.success!.yesterdayretailsales!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text("YESTERDAYS ORDERS", style: textHeading.copyWith(fontSize: 13)),
                  //           giveHeight(3),
                  //           Text(dashboradModel!.success!.yesterdayretailsales!.cnt!.toString(), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // giveHeight(7),
                  // Divider(
                  //   height: 5,
                  //   color: Colors.black26,
                  // ),
                  // giveHeight(7),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "SALES (THIS MONTH)",
                  //             style: textHeading.copyWith(fontSize: 13),
                  //           ),
                  //           giveHeight(3),
                  //           Text(formatter.format(((double.tryParse(dashboradModel!.success!.mtdallorders!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text("TOTAL ORDERS (CURRENT MONTH)",
                  //               style: textHeading.copyWith(fontSize: 13)),
                  //           giveHeight(3),
                  //           Text(dashboradModel!.success!.mtdallorders!.cnt!.toString(), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // giveHeight(7),
                  // Divider(
                  //   height: 5,
                  //   color: Colors.black26,
                  // ),
                  // giveHeight(7),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "SALES (THIS YEAR)",
                  //             style: textHeading.copyWith(fontSize: 13),
                  //           ),
                  //           giveHeight(3),
                  //           Text(formatter.format(((double.tryParse(dashboradModel!.success!.ytdallorders!.sumsubtotal?.toString() ?? "0") ?? 0) / 1.15)), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text("ORDERS (THIS YEAR)",
                  //               style: textHeading.copyWith(fontSize: 13)),
                  //           giveHeight(3),
                  //           Text(dashboradModel!.success!.ytdallorders!.cnt!.toString(), style: userText.copyWith(fontSize: 14)),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // giveHeight(7),
                  // Divider(
                  //   height: 5,
                  //   color: Colors.black26,
                  // ),
                  // giveHeight(7),
            //       Row(
            //         children: [
            //           Expanded(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   "SALES TO TARGET",
            //                   style: textHeading.copyWith(fontSize: 13),
            //                 ),
            //                 giveHeight(3),
            //                 Text(formatter.format(double.tryParse(dashboradModel!.success!.salestarget!.toString())), style: userText.copyWith(
            // color: hexToColor(dashboradModel!.success!.salestargetcol),fontSize: 14
            // ),),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //       giveHeight(7),
            //       Divider(
            //         height: 5,
            //         color: Colors.black26,
            //       ),
                ],
              ),
            )
          ],
        ),
      ):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25)),
    );
  }
  Color? hexToColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) return null;
    hexColor = hexColor.replaceAll("#", ""); // Remove "#" if present
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Add the alpha value if missing
    }
    return Color(int.parse(hexColor, radix: 16));
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
                print("hell");
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
          Text(title,textAlign:TextAlign.center,style: textHeading.copyWith(fontSize: 9),),
          giveHeight(2),
          Text(data,textAlign:TextAlign.center,style: userText,),
          giveHeight(2),
          // Icon(icon,size: 15,color: AppColors.primaryClr,),


        ],
      ),
    );
  }

}
