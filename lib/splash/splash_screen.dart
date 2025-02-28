import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../customer_dashboard/customer_homepage.dart';
import '../login_flow/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  userInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 3), (){
      if(pref.getString("user_info") != null){
        print(pref.getString("user_info"));
        Get.offAll(()=>CustomerHomepage());
      }
     else{
        Get.offAll(()=>LoginScreen());
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
      body:  Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_new.png"),
            fit: BoxFit.cover, // Ensures the image covers the whole container
          ),
        ),
      ),
      // Stack(
      //   children: [
      //
      //     Container(
      //       width: double.infinity,
      //       height: double.infinity,
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //           image: AssetImage("assets/images/splash_new.png"),
      //           fit: BoxFit.cover, // Ensures the image covers the whole container
      //         ),
      //       ),
      //     ),
      //     Container(
      //       width: double.infinity,
      //       height: double.infinity,
      //       color: Colors.black.withOpacity(0.5),
      //     ),
      //     Align(
      //         alignment: Alignment.center,
      //         child: Text("VOLPES",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontFamily: "serif",color: Colors.white.withOpacity(0.7),fontSize: 40))),
      //   ],
      // )
          
    );
  }
}
