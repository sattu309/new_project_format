import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:volpes/common_repository/common_api_method.dart';
import 'package:volpes/drawer_menu/user_drawer.dart';
import 'package:volpes/resources/api_urls.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';
import '../controllers/user_details_controller.dart';
import '../models/dashboard_model.dart';
import '../resources/common_texts_style.dart';

class CustomerHomepage extends StatefulWidget {
  const CustomerHomepage({super.key});

  @override
  State<CustomerHomepage> createState() => _CustomerHomepageState();
}

class _CustomerHomepageState extends State<CustomerHomepage> {
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
    // String formattedDate = DateFormat("dd MMMM yyyy").format(dateTime);
    return Scaffold(
      key: scaffoldKey,
      drawer: UserDrawer(),
      appBar: adminAppBar(context),
      body:
          dashboradModel != null ?
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userDetailsController.userRoles.value == "STORE" ? SizedBox():
          Image.asset(
            "assets/images/splash.png",
            fit: BoxFit.fitWidth,
            height: height * .24,
            width: width,
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
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TOTAL SALES",
                            style: textHeading,
                          ),
                          giveHeight(3),
                          Text("R2792,090", style: userText),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("TOTAL ORDERS", style: textHeading),
                          giveHeight(3),
                          Text("87", style: userText),
                        ],
                      ),
                    ),
                  ],
                ),
                giveHeight(7),
                Divider(
                  height: 5,
                  color: Colors.black26,
                ),
                giveHeight(7),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TOTAL AVERAGE ORDER VALUE",
                            style: textHeading,
                          ),
                          giveHeight(3),
                          Text(
                              dashboradModel!.success!.avgordval != null ?
                              dashboradModel!.success!.avgordval.toString():"R89,9898", style: userText),
                        ],
                      ),
                    ),
                  ],
                ),
                giveHeight(7),
                Divider(
                  height: 5,
                  color: Colors.black26,
                ),
                giveHeight(7),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "YEAR START FROM",
                            style: textHeading,
                          ),
                          giveHeight(3),
                          Text(
                              dashboradModel!.success!.yearstartdate.toString(), style: userText),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MONTH START FROM",
                            style: textHeading,
                          ),
                          giveHeight(3),
                          Text(dashboradModel!.success!.monthstartdate.toString(), style: userText),
                        ],
                      ),
                    ),
                  ],
                ),
                giveHeight(7),
                Divider(
                  height: 5,
                  color: Colors.black26,
                ),
                giveHeight(7),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userDetailsController.userRoles.value != "RETAIL" ? "STORE SALES":
                            "RETAIL SALES",
                            style: textHeading,
                          ),
                          giveHeight(3),
                          Text("R2792,090", style: userText),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              userDetailsController.userRoles.value != "RETAIL" ?"STORE ORDERS":
                              "RETAIL ORDERS", style: textHeading),
                          giveHeight(3),
                          Text("87", style: userText),
                        ],
                      ),
                    ),
                  ],
                ),
                giveHeight(7),
                Divider(
                  height: 5,
                  color: Colors.black26,
                ),
                giveHeight(7),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "C & C SALES",
                            style: textHeading,
                          ),
                          giveHeight(3),
                          Text("R2792,090", style: userText),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("C & C ORDERS", style: textHeading),
                          giveHeight(3),
                          Text("87", style: userText),
                        ],
                      ),
                    ),
                  ],
                ),
                giveHeight(7),
                Divider(
                  height: 5,
                  color: Colors.black26,
                ),
                giveHeight(7),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TOTAL SALES (CURRENT MONTH)",
                            style: textHeading,
                          ),
                          giveHeight(3),
                          Text("R2792,090", style: userText),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("TOTAL ORDERS (CURRENT MONTH)",
                              style: textHeading),
                          giveHeight(3),
                          Text("87", style: userText),
                        ],
                      ),
                    ),
                  ],
                ),
                giveHeight(7),
                Divider(
                  height: 5,
                  color: Colors.black26,
                ),
                giveHeight(7),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TOTAL SALES (CURRENT YEAR)",
                            style: textHeading,
                          ),
                          giveHeight(3),
                          Text("R2792,090", style: userText),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("TOTAL ORDERS (CURRENT YEAR)",
                              style: textHeading),
                          giveHeight(3),
                          Text("87", style: userText),
                        ],
                      ),
                    ),
                  ],
                ),
                giveHeight(7),
                Divider(
                  height: 5,
                  color: Colors.black26,
                ),
                giveHeight(7),
              ],
            ),
          )
        ],
      ):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25)),
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
      automaticallyImplyLeading: false,
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
