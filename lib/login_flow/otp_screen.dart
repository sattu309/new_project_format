import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volpes/resources/height_width.dart';
import '../Resources/app_colors.dart';
import '../customer_dashboard/customer_homepage.dart';
import '../repositories/login_repo.dart';
import '../resources/common_button.dart';
import '../resources/custom_loader.dart';

class VoplesOtpPage extends StatefulWidget {
  final String email;
  const VoplesOtpPage({super.key, required this.email});

  @override
  State<VoplesOtpPage> createState() => _VoplesOtpPageState();
}

class _VoplesOtpPageState extends State<VoplesOtpPage> {
  final otpController = TextEditingController();
  final forKey1 = GlobalKey<FormState>();
  bool isLoading = false;
  late Timer timer;
  RxInt timerSeconds = 10.obs;
  RxBool showTimer = false.obs;
  setTimer() {
    if (showTimer.value == false) {
      showTimer.value = true;
      timer = Timer.periodic(const Duration(seconds: 1), (value) {
        if (timerSeconds.value > 1) {
          timerSeconds.value--;
        } else {
          showTimer.value = false;
          timer.cancel();
          timerSeconds.value = 10;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setTimer();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/screenbg.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    giveHeight(height * .2),
                    Center(
                        child: Image.asset(
                          "assets/images/app_logo.png",
                          height: 100,
                        )),
                    giveHeight(30),
                  ],
                ),
              ),
              Positioned(
                  bottom: height* .2,
                  left: 20,
                  child: Container(
                      width: width * .89,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
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
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: forKey1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              giveHeight(height * .02),
                              const Text("Enter Verification Code",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              giveHeight(5),
                              Text("Otp has been sent to ${widget.email}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400)),
                              giveHeight(3),
                              Obx((){
                                return  Padding(
                                  padding: const EdgeInsets.only(left: 4,right:  4),
                                  child: Center(
                                    child: Text(
                                        userDetailsController.errorText1.value != "null" ?
                                        userDetailsController.errorText1.value:"",
                                        textAlign: TextAlign.center,
                                        //maxLines: 2,
                                        style: TextStyle(fontSize: 15, color: Colors.red,  fontWeight: FontWeight.w400)),
                                  ),
                                );
                              }),
                              userDetailsController.errorText1.isNotEmpty? giveHeight(3):SizedBox(),

                              PinCodeTextField(
                                mainAxisAlignment: MainAxisAlignment.center,
                                appContext: context,
                                textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                controller: otpController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                pastedTextStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                animationType: AnimationType.fade,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "                                  OTP code Required";
                                  } else if (v.length != 6) {
                                    return "                         Enter complete OTP code";
                                  }
                                  return null;
                                },
                                length: 6,
                                pinTheme: PinTheme(
                                  fieldOuterPadding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                                  borderWidth: 1,
                                  inactiveBorderWidth: 1,
                                  activeBorderWidth: 1,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(8),
                                  fieldWidth: 30,
                                  fieldHeight: 30,
                                  activeFillColor: Colors.black,
                                  inactiveColor: Colors.black,
                                  inactiveFillColor: Colors.black,
                                  selectedFillColor: Colors.black,
                                  selectedColor: Colors.black,
                                  activeColor: Colors.black,
                                ),
                                cursorColor: Colors.black,
                                enablePinAutofill: true,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  setState(() {
                                    // currentText = v;
                                  });
                                },
                              ),
                              GestureDetector(
                                  onTap: () {
                                    // if (showTimer.value == false) {
                                    //   resendOtpRepo(
                                    //       mobileNumber: widget.mobileNumber,
                                    //       context: context)
                                    //       .then((value) {
                                    //     if (value.success != null) {
                                    //       Helpers.showToast(
                                    //           value.success.toString());
                                    //       setTimer();
                                    //     } else {
                                    //       Helpers.showToast(value.error.toString());
                                    //     }
                                    //     return;
                                    //   });
                                    // }
                                  },
                                  child:
                                  Obx((){
                                    return  Text(
                                        !showTimer.value
                                            ? "Resend OTP"
                                            : "Resend OTP in 00:${timerSeconds.value > 9 ?
                                        timerSeconds.value : "0${timerSeconds.value}"}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontSize: 15,
                                            color: AppColors.primaryClr,
                                            fontWeight: FontWeight.w400));
                                  })

                              ),
                              giveHeight(18),
                              isLoading == true ?
                              Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 30)):const SizedBox(),

                              CommonAppButton(
                                title: 'CONFIRM OTP',
                                onPressed: () async {
                                  if(forKey1.currentState!.validate()){
                                    setState(() {
                                      isLoading = true;
                                    });
                                    otpVerifyRepo(email: widget.email, context: context, otp: otpController.text).then((value) async {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      if(value.success != null){
                                        SharedPreferences pref = await SharedPreferences.getInstance();
                                        String userInfo = jsonEncode({
                                          "token": value.success!.token,
                                          "id": value.success!.id,
                                          "name": value.success!.name,
                                          "lname": value.success!.lname,
                                          "mobile": value.success!.mobile,
                                          "email": value.success!.email,
                                          "role": value.success!.role,
                                        });
                                        await pref.setString("user_info", userInfo);
                                        log("USER LOGIN DETAILS ::: $userInfo");
                                        Get.offAll(()=>CustomerHomepage());
                                      }
                                    }).catchError((e){
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                  }



                                },
                              ),
                              giveHeight(height * .05),
                            ],
                          ),
                        ),
                      ))),
            ],
          ),
        ));
  }
}
