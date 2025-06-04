
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

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final userDetailsController = Get.put(UserDetailsController());

  late AnimationController _controller;
  late Animation<double> _animation;

  userInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userInfo = pref.getString("user_details");

    await Future.delayed(const Duration(seconds: 3), () {
      if (userInfo != null) {
        print(userInfo);
        if (userDetailsController.userRoles.value == "store") {
          Get.offAll(() => CustomNavigationBar());
        } else if (userDetailsController.userRoles.value == "admin") {
          Get.offAll(() => AdminHomepage());
        } else if (userDetailsController.userRoles.value == "general") {
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

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();
    userInfo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/new_bg.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Center(
            child: ScaleTransition(
              scale: _animation,
              child: FadeTransition(
                opacity: _animation,
                child: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Image.asset("assets/images/zone_logo.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
