import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quick_quiz/quick_quiz.dart';
import 'package:volpes/resources/app_colors.dart';
import '../common_repository/common_api_method.dart';
import '../models/quiz_questions_model.dart';
import '../resources/api_urls.dart';

class DemoQuiz extends StatefulWidget {
  final String challengerID;
  final String challengeID;
  const DemoQuiz({super.key, required this.challengerID, required this.challengeID});

  @override
  State<DemoQuiz> createState() => _DemoQuizState();
}

class _DemoQuizState extends State<DemoQuiz> {
  List<String> questionList = [];
  List<dynamic> responseList = [];
  List<String> correctAnswerList = [];

  Repositories repositories = Repositories();
  QuizQuestionsModel? questionsModel;
  getQuizQuestion() {
    repositories.getApi(url: "${ApiUrls.getQuizQuestionUrl}/${widget.challengerID}/${widget.challengeID}").then((value) {
      questionsModel = QuizQuestionsModel.fromJson(jsonDecode(value));
      setState(() {
        questionList = questionsModel!.success!.questionsdata!
            .map((ques) => ques.question.toString())
            .toList();

        // Explicitly casting each response and answer as String
        responseList = questionsModel!.success!.questionsdata!
            .map((ques) => List<String>.from(ques.responses!.map((response) => response.toString())))
            .toList();

        correctAnswerList = questionsModel!.success!.questionsdata!
            .map((ques) => ques.answers.toString())  // Ensure answers are also cast to String
            .toList();

        print("ALL DATA $questionList");
        print("ALL DATA $responseList");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getQuizQuestion();
  }
  @override
  Widget build(BuildContext context) {
    final quiz = Quiz(
      questions: List.generate(questionList.length, (index) {
        List<String> options = List<String>.from(responseList[index])
            .where((option) => option.toString().trim().isNotEmpty)
            .toList();
        int correctAnswerIndex = options.indexOf(correctAnswerList[index]);
        if (correctAnswerIndex == -1) {
          print("Error: Correct answer not found in options for question: ${questionList[index]}");
          correctAnswerIndex = 0;
        }

        return QuestionModel(
          question: questionList[index],
          options: options,
          correctAnswerIndex: correctAnswerIndex,
        );
      }),
      timerDuration: 550,
    );

    // final quiz = Quiz(
    //   questions: List.generate(questionList.length, (index) {
    //     // Ensure responseList[index] is a List<String>
    //     List<String> options = List<String>.from(responseList[index])
    //         .where((option) => option.toString().trim().isNotEmpty)
    //         .toList();
    //
    //     // Get the correct answers for this question
    //     List<String> correctAnswers = correctAnswerList[index]
    //         .split(',') // Assuming answers are stored as "Option1,Option2"
    //         .map((answer) => answer.trim()) // Trim spaces
    //         .toList();
    //
    //     // Find indexes of all correct answers in the options list
    //     List<int> correctAnswerIndexes = options
    //         .asMap()
    //         .entries
    //         .where((entry) => correctAnswers.contains(entry.value))
    //         .map((entry) => entry.key)
    //         .toList();
    //     return QuestionModel(
    //       question: questionList[index],
    //       options: options,
    //       correctAnswerIndex: correctAnswerIndexes, // Now supports multiple correct answers
    //     );
    //   }),
    //   timerDuration: 550,
    // );


    return Scaffold(
      body:
          questionsModel != null ?
          Padding(
            padding: const EdgeInsets.only(top: 50,bottom: 20),
            child: QuizPage(
              primaryColor: AppColors.primaryClr,
              quiz: quiz
            ),
          ):Center(child: CircularProgressIndicator(color: AppColors.primaryClr,))
    );
  }
  // getQuizRus
}
