import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/resources/common_textfields.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/height_width.dart';

import '../controllers/user_details_controller.dart';
import '../repositories/login_repo.dart';
import '../resources/common_button.dart';
import '../resources/custom_loader.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userDetailsController = Get.put(UserDetailsController());
  final forKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;


    var customHeight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return
      Scaffold(
        // resizeToAvoidBottomInset: false,
      body:
      Stack(
        children: [

          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/new_splash.jpeg"),
                fit: BoxFit.cover, // Ensures the image covers the whole container
              ),
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   height: double.infinity,
          //   // color: Colors.black.withOpacity(0.5),
          //   color: AppColors.primaryClr.withOpacity(0.10),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(12.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       giveHeight(customHeight * .20),
          //       Center(
          //           child: Image.asset(
          //             "assets/images/app_logo.png",
          //             height: 100,
          //           )),
          //       giveHeight(30),
          //     ],
          //   ),
          // ),
          Center(
            child: isLoading
                ? threeArchedCircle(color: Colors.white, size: 30)
                : SizedBox(), // Keep height fixed when loader is hidden
          ),
          Positioned(
            bottom: 0,
            // bottom: customHeight* .27,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              width: width,
              // width: width * .80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
                // borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(
                      1,
                      1,
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Form(
                  key: forKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                     // Text(screenHeight.toString(),style: userText,),
                      //Text(screenWidth.toString(),style: userText),
                      Text("Welcome back! Please login to continue",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),),
                      Obx((){
                        return  Padding(
                          padding: const EdgeInsets.only(left: 4,right:  4),
                          child: Text(
                              userDetailsController.errorText.value != "null" ?
                              userDetailsController.errorText.value:"",
                              textAlign: TextAlign.center,
                              //maxLines: 2,
                              style: TextStyle(fontSize: 14, color: Colors.red,  fontWeight: FontWeight.w400)),
                        );
                      }),
                      userDetailsController.errorText.value != "" ?
                        giveHeight(6):SizedBox(),
                      CustomTextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hint: "Enter Email",
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter your email '),
                          EmailValidator(errorText: "Please enter the valid email")
                        ]).call,

                      ),
                      giveHeight(20),

                      CommonAppButton(title: "SIGN IN",onPressed: (){
                        if(forKey.currentState!.validate()){
                          setState(() {
                            isLoading = true;
                          });
                          createLogin(email: emailController.text, context: context).then((value){
                            setState(() {
                              isLoading = false;
                            });
                            if(value.success != null){
                              userDetailsController.errorText.value = "";
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return VoplesOtpPage(email: emailController.text,);
                              }));
                            }
                          }).catchError((e){
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }

                        }, isArrow: true,),


                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
