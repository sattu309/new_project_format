import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_bottom_bar.dart';
import '../controllers/user_details_controller.dart';
import '../customer_dashboard/admin_homepage.dart';
import '../customer_dashboard/general_dashboard.dart';
import '../login_flow/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final userDetailsController = Get.put(UserDetailsController());

  userInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userInfo = pref.getString("user_details");
    await Future.delayed(Duration(seconds: 3),(){
      if (userInfo != null) {
        print(userInfo);
        // Get.offAll(() => CustomNavigationBar());
          if (userDetailsController.userRoles.value == "store") {
            Get.offAll(() => CustomNavigationBar());
            // Get.offAll(() => GeneralDashboard());
          } else if(userDetailsController.userRoles.value == "admin"){
            Get.offAll(() => AdminHomepage());
          }
            else if(userDetailsController.userRoles.value == "general"){
               Get.offAll(() => GeneralDashboard());
            }
        } else {
        Get.offAll(() => LoginScreen());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    userInfo();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // Container(
      //   width: double.infinity,
      //   height: double.infinity,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage("assets/images/new_splash.jpeg"),
      //       fit: BoxFit.cover, // Ensures the image covers the whole container
      //     ),
      //   ),
      // ),
      Stack(
        children: [

          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/new_bg.jpeg"),
                fit: BoxFit.cover, // Ensures the image covers the whole container
              ),
            ),
          ),
          Center(child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Image.asset("assets/images/zone_logo.png"),
          ))
        ],
      )
          
    );
  }
}
