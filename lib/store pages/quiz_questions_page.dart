import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';

import '../common_repository/common_api_method.dart';
import '../models/quiz_questions_model.dart';
import '../resources/api_urls.dart';

class QuizQuestionScreen extends StatefulWidget {
  final String challengerID;
  final String challengeID;
  const QuizQuestionScreen({super.key, required this.challengerID, required this.challengeID});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  PageController controller = PageController();
 Map<String,dynamic> allQuestions= {};
  List<Map<String, dynamic>> selectedAnswers = [];
  List<Map<String, dynamic>> quizResult = [];
  int pageIndex = 0;
  int nextBtn = -1;

  bool loginLoaded = false;
  Repositories repositories = Repositories();
  QuizQuestionsModel? questionsModel;
  getQuizQuestion(){
    repositories.getApi(url: "${ApiUrls.getQuizQuestionUrl}/${widget.challengerID}/${widget.challengeID}").then((value){
      questionsModel = QuizQuestionsModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getQuizQuestion();
    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      PageView.builder(
          itemCount: questionsModel!.success!.questionsdata!.length,
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          pageSnapping: true,
          itemBuilder: (context, index) {
            final questions = questionsModel!.success!.questionsdata![index];
            return
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "QUIZ",
                      style: userText.copyWith(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    Text(
                      questions.question.toString(),
                      textAlign: TextAlign.center,
                      style: userText.copyWith(fontSize: 17,color: AppColors.primaryClr),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: questions.responses!
                          .where((answer) => answer.isNotEmpty)
                          .toList()
                          .asMap()
                          .entries
                          .map((entry) {
                        final index1 = entry.key;
                        final answer = entry.value;
                        final ques = questions.question.toString();
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: SizedBox(
                            height: 40,
                            width: width,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if(quizResult.contains(ques)){

                                  }
                                  pageIndex = index1;
                                  nextBtn = pageIndex;
                                  print("ANSWER INDEX ${pageIndex}");
                                  print(allQuestions[questions.question.toString()]);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: pageIndex == index1
                                    ? Colors.orange
                                    : AppColors.primaryClr,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                              ),
                              child: Text(
                                answer, // Display the answer directly
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),


                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            controller.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease);
                            setState(() {
                              pageIndex--;
                            });
                          }, // Disabled
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          ),
                          child: Text("PREV"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (pageIndex < questions.question.length - 1) {
                              controller.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease);
                              setState(() {
                                pageIndex++;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: nextBtn == pageIndex
                                ? AppColors.primaryClr : Colors.grey.shade300,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          ),
                          child: Text("NEXT"),
                        ),
                      ],
                    ),
                  ],
                                  ),
                ),
              );

          }),
    );
  }
}
