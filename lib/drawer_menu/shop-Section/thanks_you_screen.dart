import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/common_bottom_bar.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_button.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/height_width.dart';

import '../../controllers/user_details_controller.dart';

class ThanksYouScreen extends StatefulWidget {
  final String cartTotal;
  final String payMethod;
  final String orderId;
  const ThanksYouScreen({super.key, required this.cartTotal, required this.payMethod, required this.orderId});

  @override
  State<ThanksYouScreen> createState() => _ThanksYouScreenState();
}

class _ThanksYouScreenState extends State<ThanksYouScreen> {
  final userController = Get.put(UserDetailsController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body:
      Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          giveHeight(height*.3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(child: Text("ORDER RECEIVED",style: userText.copyWith(color: AppColors.primaryClr,fontSize: 18),)),
                  giveHeight(2),
                  Center(child: Text("Thank You ${userController.userName.value}",style: userText.copyWith(fontSize: 13),)),
                  giveHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align from start
                    children: [
                      Text("ORDER NUMBER:", style: userText.copyWith(color: AppColors.titleClr)),
                      SizedBox(width: 10), // Add spacing manually
                      Text(widget.orderId.toString(), style: userText.copyWith(color: AppColors.titleClr)),
                    ],
                  ),
                  giveHeight(7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Total:", style: userText.copyWith(color: AppColors.titleClr)),
                      SizedBox(width: 10), // Add spacing manually
                      Text("R${widget.cartTotal.toString()}", style: userText.copyWith(color: AppColors.titleClr)),
                    ],
                  ),
                  giveHeight(7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Payment Method:", style: userText.copyWith(color: AppColors.titleClr)),
                      SizedBox(width: 10),
                      Text(widget.payMethod.toString(), style: userText.copyWith(color: AppColors.titleClr)),
                    ],
                  ),
                  giveHeight(20),
                  CommonAppButtonGreen(title: "View details", onPressed: (){}, isArrow: false, color: Colors.green,),
                  giveHeight(10),
                  CommonAppButtonGreen(title: "Continue Shopping", onPressed: (){
                    Get.offAll(()=>CustomNavigationBar());
                  }, isArrow: false, color: AppColors.primaryClr,)
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
