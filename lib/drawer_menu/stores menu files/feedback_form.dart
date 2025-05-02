import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/resources/common_button.dart';
import 'package:volpes/resources/common_textfields.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/height_width.dart';

import '../../Resources/app_colors.dart';
import '../../repositories/login_repo.dart';
import '../../resources/custom_loader.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final feedbackKey = GlobalKey<FormState>();
  final feedbackTitle = TextEditingController();
  final feedbackAnswer = TextEditingController();
  final isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customerAppBar(context, "Recommendations"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
        child: Form(
          key: feedbackKey,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("We truly value your feedback – it helps us get better every day.Thanks for taking the time!",style: textHeading,textAlign: TextAlign.center,)),
              ),
              giveHeight(10),
              Text(
                "Title",
                style: textHeading,
              ),
              giveHeight(3),
              CustomTextField(
                controller: feedbackTitle,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Please enter your title '),
                ]).call,
                hint: "title",
              ),
              giveHeight(10),
              Text(
                "Feedback",
                style: textHeading,
              ),
              giveHeight(3),
              TextFormField(
                controller: feedbackAnswer,
                style: TextStyle(
                    fontSize: 13, color: Colors.black54.withOpacity(0.6)),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Please give your feedback '),
                ]).call,
                minLines: 5,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "feedback",
                  focusColor: AppColors.primaryClr,
                  hintStyle: TextStyle(
                      color: Color(0xffE4E4E4),
                      fontSize: 12,
                      fontFamily: "cabin"),
                  filled: true,
                  fillColor: Color(0xffF6F6F6).withOpacity(.10),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffE4E4E4),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE4E4E4)),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffE4E4E4), width: 3.0),
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              giveHeight(30),
              Obx(() => isLoading.value
                  ?  Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25))
                  : CommonAppButton(
                        title: "SUBMIT",
                        onPressed: () {
                          if (feedbackKey.currentState!.validate()) {
                            isLoading.value = true;
                            feedbackFormRepo(
                                title: feedbackTitle.text,
                                feedback: feedbackAnswer.text,
                                context: context).then((value){
                              isLoading.value = false;
                              if(value.success != null){
                                    feedbackTitle.clear();
                                      feedbackAnswer.clear();
                                    feedbackKey.currentState!.reset();
                                    showSnackBarView(context: context, msg: "Your feedback has been sent.", bgColor: AppColors.primaryClr);
                                  }
                            }).catchError((e){
                            });
                          }
                        },
                        isArrow: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
