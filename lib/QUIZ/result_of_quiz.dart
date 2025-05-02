import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/common_repository/common_api_method.dart';
import 'package:volpes/resources/api_urls.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';
import 'package:volpes/store%20pages/quiz_component/common_button.dart';

import '../common_bottom_bar.dart';
import '../controllers/main_controller.dart';
import '../models/quiz_reuslt_data_display.dart';

class ResultOfQuiz extends StatefulWidget {
  final quizResultID;
  const ResultOfQuiz({super.key, required this.quizResultID});

  @override
  State<ResultOfQuiz> createState() => _ResultOfQuizState();
}

class _ResultOfQuizState extends State<ResultOfQuiz> {
  final controller = Get.put(MainHomeController());
  QuizResultDataDisplay? quizResultDataDisplay;
  Repositories repositories = Repositories();
  getQuizResultData() async {
    await repositories
        .getApi(url: "${ApiUrls.getQuizData}/${widget.quizResultID}")
        .then((value) {
      quizResultDataDisplay = QuizResultDataDisplay.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    log("QUIZ DATA?? ${widget.quizResultID}");
    getQuizResultData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "QUIZ RESULT",
            style:
                textHeading.copyWith(fontSize: 18, color: AppColors.primaryClr),
          ),
          centerTitle: true,
        ),
        body:
            quizResultDataDisplay != null ?
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Card(
                  shape: Border.all(color: Colors.grey.shade200),
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        giveHeight(5),
                        Center(
                            child: Text(
                          "CONGRATULATION",
                          style: textHeading.copyWith(
                              fontSize: 16, color: Colors.black),
                        )),
                        giveHeight(5),
                        Center(
                          child: Image.asset(
                            "assets/images/quiz_logo.jpeg",
                            height: 50,
                            width: 50,
                          ),
                        ),
                        giveHeight(5),
                        Center(
                            child: Text(
                          "YOUR SCORE",
                          style: textHeading.copyWith(
                              fontSize: 15, color: Colors.black),
                        )),
                        giveHeight(7),
                        Center(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text:
                                    "${quizResultDataDisplay!.quizresult!.markobtained.toString()} / ",
                                style: textHeading.copyWith(
                                    fontSize: 15, color: Color(0xff00df00))),
                            TextSpan(
                                text: quizResultDataDisplay!
                                    .quizresult!.totalmarks
                                    .toString(),
                                style: textHeading.copyWith(
                                    fontSize: 15, color: Colors.black)),
                          ])),
                        ),
                        ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                quizResultDataDisplay!.testResults!.length,
                            itemBuilder: (BuildContext context, index) {
                              final quesAns =
                                  quizResultDataDisplay!.testResults![index];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Q ${index+1} ${quesAns.question.toString()}",
                                    style: textHeading.copyWith(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  giveHeight(5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if(quesAns.option1!.isNotEmpty)
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "A.",
                                                style: textHeading.copyWith(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(width: 4), // spacing between "A." and the answer
                                              Expanded(
                                                child: Text(
                                                  quesAns.option1.toString(),
                                                  style: textHeading.copyWith(
                                                    color: Colors.black54,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),


                                        // Text(
                                        //     "A. ${quesAns.option1.toString()}",
                                        //   textAlign: TextAlign.start,
                                        //   style: textHeading.copyWith(
                                        //     color: Colors.black54,
                                        //       fontSize: 13,
                                        //       fontWeight: FontWeight.w500),
                                        // ),
                                        if(quesAns.option2!.isNotEmpty)
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "B.",
                                                style: textHeading.copyWith(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(width: 4), // spacing between "A." and the answer
                                              Expanded(
                                                child: Text(
                                                  quesAns.option2.toString(),
                                                  style: textHeading.copyWith(
                                                    color: Colors.black54,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if(quesAns.option3!.isNotEmpty)
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "C.",
                                                style: textHeading.copyWith(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(width: 4), // spacing between "A." and the answer
                                              Expanded(
                                                child: Text(
                                                  quesAns.option3.toString(),
                                                  style: textHeading.copyWith(
                                                    color: Colors.black54,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if(quesAns.option4!.isNotEmpty)
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "D.",
                                                style: textHeading.copyWith(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(width: 4), // spacing between "A." and the answer
                                              Expanded(
                                                child: Text(
                                                  quesAns.option4.toString(),
                                                  style: textHeading.copyWith(
                                                    color: Colors.black54,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        giveHeight(5)

                                      ],
                                    ),
                                  ),
                                  if(quesAns.isCorrect == 1)
                                  Text(
                                    "YOU ANSWERED: ${(quesAns.isCorrect1 == 1 ? " A" : "") + (quesAns.isCorrect2 == 1 ? " B" : "") + (quesAns.isCorrect3 == 1 ? " C" : "") + (quesAns.isCorrect4 == 1 ? " D" : "")}",
                                    style: textHeading.copyWith(color: Color(0xff00df00)),
                                  ),
                                  giveHeight(3),
                                  if(quesAns.isCorrect == 0)
                                  Text(
                                    "YOU ANSWERED: ${(quesAns.isCorrect1 == 1 ? " A" : "") + (quesAns.isCorrect2 == 1 ? " B" : "") + (quesAns.isCorrect3 == 1 ? " C" : "") + (quesAns.isCorrect4 == 1 ? " D" : "")   }",
                                    style: textHeading.copyWith(color: Color(0xffdc3545)),
                                  ),
                                  if(quesAns.isCorrect == 0)
                                    Text(
                                      "CORRECT ANSWERED: ${[
                                        if (quesAns.selectedanswers!.option1 == 1) "A",
                                        if (quesAns.selectedanswers!.option2 == 1) "B",
                                        if (quesAns.selectedanswers!.option3 == 1) "C",
                                        if (quesAns.selectedanswers!.option4 == 1) "D",
                                      ].join(', ')}",
                                      style: textHeading.copyWith(color: Color(0xff003161)),
                                    ),

                                  // Text(
                                  //   "CORRECT ANSWERED: ${(quesAns.selectedanswers!.option1 == 1 ? "A " : "") + (quesAns.selectedanswers!.option2 == 1 ? "B " : "") + (quesAns.selectedanswers!.option3 == 1 ? "C " : "") + (quesAns.selectedanswers!.option4 == 1 ? "D" : "")}",
                                  //   style: textHeading.copyWith(color: Color(0xff003161)),
                                  // ),
                                  giveHeight(5),
                                ],
                              );
                            }),
                        giveHeight(10),
                        Text("You did great job. Learn more by taking part in more quizes.",textAlign: TextAlign.center,style: userText,),
                        giveHeight(10),
                        Center(child: buttonCommon(title: "START OVER", onTapp: (){
                                Get.offAll(()=>CustomNavigationBar());
                        }))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 30
            ),));
  }
}
