import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/QUIZ/quiz_model.dart';
import 'package:volpes/QUIZ/result_of_quiz.dart';
import 'package:volpes/QUIZ/review_answer.dart';
import 'package:volpes/resources/app_colors.dart';
import '../controllers/main_controller.dart';
import '../models/quiz_reuslt_data_display.dart';
import '../repositories/save_quiz_repo.dart';
import 'option_tile.dart';

class QuizPage extends StatefulWidget {
  /// Instance of quiz that holds all information
  final Quiz quiz;

  final Color primaryColor;
  final String challengerId;

  /// Constructor
  const QuizPage(
      {super.key,
        required this.quiz,
        this.primaryColor = const Color(0xffDA3732),  required this.challengerId});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  /// Instance of timer to show countdown during the quiz
  late Timer _timer;

  /// Remaining time for the current quiz
  late int remainingTime;

  /// Instance that holds index of the current question being displayed
  int currentQuestionIndex = 0;

  /// Holds the selected option index for the current question being displayed
  // int? selectedOption;
  List<int> selectedOption = [];

  /// Counter to track number of times user has retried the quiz
  int retryCount = 0;
  final controller = Get.put(MainHomeController());


  @override
  void initState() {
    super.initState();

    /// Initializing remaining time with quiz's total time limit
    remainingTime = widget.quiz.timerDuration!;

    /// Start the timer countdown
    startTimer();
  }

  @override
  void dispose() {
    /// Cancel timer when widget is removed
    _timer.cancel();
    super.dispose();
  }

  /// Reset quiz state to restart quiz from the start
  void resetQuiz() {
    /// Cancel current timer
    _timer.cancel();

    setState(() {
      /// Reset remaining time, currentQuestionIndex, selectedOption and increased retryCount
      remainingTime = widget.quiz.timerDuration!;
      currentQuestionIndex = 0;
      for (var item in widget.quiz.questions) {
        item.selectedAnswerIndex = [];
      }
      selectedOption = [];
      retryCount++;
    });

    /// Restart timer for new session
    startTimer();
  }

  /// Function that starts timer that decreases remaining time each second
  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (remainingTime > 0) {
          setState(() {
            remainingTime--;
          });
        } else {
          // navigateToScore();
        }
      },
    );
  }

  /// Navigates to score page
  // void navigateToScore() {
  //   _timer.cancel();
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => Score(
  //         quiz: widget.quiz,
  //         duration: (widget.quiz.timerDuration! - remainingTime),
  //         onRetry: resetQuiz,
  //       ),
  //     ),
  //   );
  // }

  /// Displays next question or navigates to score page for last question
  void goToNextQuestion() {
    if (currentQuestionIndex < widget.quiz.questions.length - 1) {
      // submitQuizData(widget.quiz);
      setState(() {
        currentQuestionIndex++;
        selectedOption = [];
      });
    } else if (currentQuestionIndex == widget.quiz.questions.length - 1) {
      // navigateToScore();
      Get.to(()=>ReviewAnswer(quiz: widget.quiz,));
    }
  }

  submitQuizData(Quiz quiz) {
    List<Map<String, dynamic>> quizDataToApi = [];
    final quizDataLength = quiz.questions.length;
    try{
      for (int i = 0; i < quizDataLength; i++) {
        final question = quiz.questions[i];
        final selectedIndex = question.selectedAnswerIndex;
        final correctIndex = question.correctAnswerIndex;
        // final userAnswerText = selectedIndex.isNotEmpty
        //     ? selectedIndex.map((i) => question.options[i].toString()).join(', ')
        //     : 'No answer';
        final List<String> responses = selectedIndex.map((i) => question.options[i].toString()).toList();

        final correctAnswerText = correctIndex.isNotEmpty
            ? correctIndex.map((i) => question.options[i]).join(', ')
            : 'No correct answer';

        final isCorrect = ListEquality().equals(
          question.selectedAnswerIndex,
          question.correctAnswerIndex,
        );

        Map<String, dynamic> quizItem = {
          "question": question.question,
          "answers": [correctAnswerText],
          "responses":  responses,
          "isRight": isCorrect
        };
        quizDataToApi.add(quizItem);
      }
    }catch (e, stack) {
      print("Error formatting quiz data: $e");
      print("Stack: $stack");
    }
    log("Formatted Quiz Data: ${jsonEncode(quizDataToApi)}");
    String allQuizData = jsonEncode(quizDataToApi);
    saveQuizRepo(
        quizData: allQuizData,
        context: context,
        challengerId: widget.challengerId).then((value){
      if(value.success != null){
        log("QUIZ RESULT PRE: ${value.success.toString()}");
         Get.offAll(()=>ResultOfQuiz(quizResultID: value.success.toString(),));
      }
    });
  }





  @override
  Widget build(BuildContext context) {
    QuestionModel currentQuestion = widget.quiz.questions[currentQuestionIndex];
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${currentQuestionIndex + 1} of ${widget.quiz.questions.length}',
                  style:  TextStyle(fontSize: 14, color: AppColors.primaryClr ),
                ),
                // InkWell(
                //   onTap: () {
                //     goToNextQuestion();
                //   },
                //   child: const Text(
                //     'Skip',
                //     style: TextStyle(color: Colors.grey, fontSize: 12),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            // TimerIndicator(
            //   key: ValueKey(retryCount),
            //   totalTime: widget.quiz.timerDuration!.toDouble(),
            //   primaryColor: widget.primaryColor,
            // ),
            // const SizedBox(height: 4),
            // Text(
            //   getformatTime(remainingTime),
            //   style: const TextStyle(
            //     fontSize: 10,
            //     color: Colors.grey,
            //   ),
            // ),
            // const SizedBox(height: 20),
            Text(
              currentQuestion.question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:Colors.black),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.options.length,
                itemBuilder: (context, index) {
                  return OptionTile(
                      optionText: currentQuestion.options[index],
                      isSelected: selectedOption.contains(index),
                      onTap: () {
                        setState(() {
                          if (selectedOption.contains(index)) {
                            selectedOption.remove(index); // Deselect
                          } else {
                            selectedOption.add(index); // Select
                          }
                        });
                        print("OPETIOIN::: ${selectedOption.toList()}");

                      },
                      serialNumber: "${index + 1}",
                      primaryColor: widget.primaryColor);
                },
              ),
            ),
            const SizedBox(height: 20),
            // currentQuestionIndex == widget.quiz.questions.length - 1 ?
            // SizedBox(
            //   width: double.infinity,
            //   height: 50,
            //   child: ElevatedButton(
            //     onPressed: selectedOption.isNotEmpty
            //         ? () {
            //       submitQuizData(widget.quiz);
            //
            //     }:null,
            //
            //     style: ElevatedButton.styleFrom(
            //       padding: const EdgeInsets.symmetric(vertical: 16.0),
            //       backgroundColor: Color(0xffd3000c),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //     ),
            //     child:  Text(
            //       selectedOption.isNotEmpty ?  'FINISH' : "Next",
            //       style: TextStyle(fontSize: 16, color: Colors.white),
            //     ),
            //   ),
            // ):
            // SizedBox(
            //   width: double.infinity,
            //   height: 50,
            //   child: ElevatedButton(
            //     onPressed: selectedOption.isNotEmpty
            //         ? () {
            //       currentQuestion.selectedAnswerIndex = List<int>.from(selectedOption);
            //       goToNextQuestion();
            //     }
            //         : null,
            //     style: ElevatedButton.styleFrom(
            //       padding: const EdgeInsets.symmetric(vertical: 16.0),
            //       backgroundColor: widget.primaryColor,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //     ),
            //     child: const Text(
            //       'Next',
            //       style: TextStyle(fontSize: 16, color: Colors.white),
            //     ),
            //   ),
            // ),

            Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [
                if (currentQuestionIndex > 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentQuestionIndex--;
                          selectedOption = List<int>.from(widget.quiz.questions[currentQuestionIndex].selectedAnswerIndex ?? []);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Previous',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                if (currentQuestionIndex > 0)
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectedOption.isNotEmpty
                        ? () {
                      currentQuestion.selectedAnswerIndex = List<int>.from(selectedOption);
                      if (currentQuestionIndex == widget.quiz.questions.length - 1) {
                        submitQuizData(widget.quiz);
                      } else {
                        goToNextQuestion();
                      }
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: currentQuestionIndex == widget.quiz.questions.length - 1
                          ? const Color(0xffd3000c)
                          : widget.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      currentQuestionIndex == widget.quiz.questions.length - 1
                          ? (selectedOption.isNotEmpty ? 'FINISH' : 'Next')
                          : 'Next',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
