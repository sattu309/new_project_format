import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:volpes/resources/app_colors.dart';
import '../QUIZ/quiz_model.dart';
import '../QUIZ/quiz_page.dart';
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
            .map((ques) => ques.answers.toString())
            .toList();

        print("ALL DATA $questionList");
        print("ALL DATA ${jsonEncode(responseList)}");
        print("ALL DATA $correctAnswerList");
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
    // final quiz = Quiz(
    //   questions: List.generate(questionList.length, (index) {
    //     List<String> options = List<String>.from(responseList[index])
    //         .where((option) => option.toString().trim().isNotEmpty)
    //         .toList();
    //     int correctAnswerIndex = options.indexOf(correctAnswerList[index]);
    //     if (correctAnswerIndex == -1) {
    //       print("Error: Correct answer not found in options for question: ${questionList[index]}");
    //       correctAnswerIndex = 0;
    //     }
    //
    //     return QuestionModel(
    //       question: questionList[index],
    //       options: options,
    //       correctAnswerIndex: correctAnswerIndex,
    //     );
    //   }),
    //   timerDuration: 550,
    // );

    final quiz = Quiz(
      questions: List.generate(questionList.length, (index) {
        List<String> options = List<String>.from(responseList[index])
            .where((option) => option.toString().trim().isNotEmpty)
            .toList();

        String cleanedAnswer = correctAnswerList[index]
            .replaceAll('[', '')
            .replaceAll(']', '')
            .trim();

        List<String> correctAnswers = [cleanedAnswer];

        List<int> correctAnswerIndexes = correctAnswers
            .map((answer) => options.indexWhere(
              (option) => option.trim().toLowerCase() == answer.toLowerCase(),
        ))
            .where((idx) => idx != -1)
            .toList();

        log("CORRECT ANSWER INDEXES ::> $correctAnswerIndexes");

       // old one
        // List<int> correctAnswerIndexes = options
        //     .asMap()
        //     .entries
        //     .where((entry) {
        //   bool isCorrect = correctAnswers.any((ans) {
        //     bool result = compareStrings(ans, entry.value);
        //     if (!result) {
        //       print('Comparing "${ans}" with "${entry.value}" -> Incorrect');
        //       print('Normalized: "${normalizeString(ans)}" with "${normalizeString(entry.value)}"');
        //     }
        //     return result;
        //   });
        //   return isCorrect;
        // })
        //     .map((entry) => entry.key)
        //     .toList();
        // log("THIS IS CORRECT ANSWER INDEX ${correctAnswerIndexes}");






        return QuestionModel(
          question: questionList[index],
          options: options,
          correctAnswerIndex: correctAnswerIndexes,
        );
      }),
      timerDuration: 550,

    );


    return Scaffold(
      body:
          questionsModel != null ?
          Padding(
            padding: const EdgeInsets.only(top: 50,bottom: 20),
            child: QuizPage(
              primaryColor: AppColors.primaryClr,
              quiz: quiz,
              challengerId: widget.challengerID,
            ),
          ):Center(child: CircularProgressIndicator(color: AppColors.primaryClr,))
    );
  }


  bool compareStrings(String ans, String value) {
    // Normalize the strings by trimming spaces, converting to lowercase, and removing punctuation
    return normalizeString(ans) == normalizeString(value);
  }

// Helper method to normalize a string by removing extra spaces and punctuation
  String normalizeString(String str) {
    // Trim spaces, convert to lowercase, and remove punctuation (e.g., commas, periods)
    return str.trim().toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').replaceAll(RegExp(r'\s+'), ' ');
  }
}
