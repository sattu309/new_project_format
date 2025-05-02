
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/QUIZ/quiz_model.dart';

import '../controllers/main_controller.dart';

/// Stateless widget to display the review of the quiz
class ReviewAnswer extends StatefulWidget {
  /// Quiz object containing all information of quiz
  final Quiz quiz;

  /// Constructor
  const ReviewAnswer({super.key, required this.quiz});

  @override
  State<ReviewAnswer> createState() => _ReviewAnswerState();
}

class _ReviewAnswerState extends State<ReviewAnswer> {
  final controller = Get.put(MainHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
              const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Review Answers",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.quiz.questions.length,
                itemBuilder: (context, index) {
                  final question = widget.quiz.questions[index];
                  final userAnswerIndex = question.selectedAnswerIndex;
                  final correctAnswerIndex = question.correctAnswerIndex;
                  final userAnswerText = userAnswerIndex.map((i) => question.options[i]).join(', ');
                  // Colors for answers text
                  final userAnswerColor = userAnswerIndex == correctAnswerIndex
                      ? Colors.greenAccent[700]
                      : Colors.redAccent[700];
                  const correctAnswerColor = Colors.blueAccent;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${index + 1}. ${question.question}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1D2671),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              userAnswerIndex.isNotEmpty
                                  ? "Your Answer: ${userAnswerText}"
                                  : "You skipped this question",
                              style: TextStyle(color: userAnswerColor),
                            ),
                            Text(
                              "Correct Answer: ${correctAnswerIndex.map((i) => question.options[i]).join(', ')}",
                              style: const TextStyle(color: correctAnswerColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
