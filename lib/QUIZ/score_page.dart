// // import 'package:flutter/material.dart';
// // import 'package:quick_quiz/src/pages/review_answer.dart';
// // import 'package:quick_quiz/src/Model/quiz_model.dart';
// // import 'package:quick_quiz/src/utils/utils.dart';
// // import 'package:quick_quiz/src/widgets/action_button.dart';
// // import 'package:quick_quiz/src/widgets/stat_item.dart';
// // import 'package:quick_quiz/src/widgets/score_indicator.dart';
// //
// // /// Widget that displays the summary of the quiz
// // class Score extends StatefulWidget {
// //   /// Quiz object containing all information about the quiz
// //   final Quiz quiz;
// //
// //   /// Duration the quiz lasted
// //   final int duration;
// //
// //   /// Callback function to retry the quiz
// //   final VoidCallback onRetry;
// //
// //   /// Constructor
// //   const Score({
// //     super.key,
// //     required this.quiz,
// //     required this.duration,
// //     required this.onRetry,
// //   });
// //
// //   @override
// //   State<Score> createState() => _ScoreState();
// // }
// //
// // class _ScoreState extends State<Score> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return PopScope(
// //       canPop: false,
// //       child: Scaffold(
// //         backgroundColor: Colors.black,
// //         body: Stack(
// //           children: [
// //             Container(
// //               decoration: const BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [Color(0xFF8360c3), Color(0xFF2ebf91)],
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                 ),
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.only(top: 100, bottom: 20),
// //               child: Column(
// //                 children: [
// //                   Text(
// //                     getFormattedDateTime(),
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       color: Colors.white.withOpacity(0.8),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   const Text(
// //                     "Quiz Summary",
// //                     style: TextStyle(
// //                       fontSize: 24,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.white,
// //                       shadows: [
// //                         Shadow(
// //                             color: Colors.black38,
// //                             offset: Offset(2, 2),
// //                             blurRadius: 4)
// //                       ],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 50),
// //                   Stack(
// //                     alignment: Alignment.center,
// //                     children: [
// //                       CustomPaint(
// //                         size: const Size(150, 150),
// //                         painter:
// //                         ScoreIndicator(accuracy: widget.quiz.totalAccuracy),
// //                       ),
// //                       Column(
// //                         children: [
// //                           Text(
// //                             "${widget.quiz.totalCorrectAnswers}",
// //                             style: const TextStyle(
// //                               fontSize: 36,
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.white,
// //                               shadows: [
// //                                 Shadow(
// //                                     color: Colors.black54,
// //                                     offset: Offset(2, 2),
// //                                     blurRadius: 5)
// //                               ],
// //                             ),
// //                           ),
// //                           Text(
// //                             "Out of ${widget.quiz.totalQuestions}",
// //                             style: const TextStyle(
// //                               fontSize: 14,
// //                               color: Colors.white70,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const Positioned(
// //                         bottom: 0,
// //                         child: Text(
// //                           "Score",
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.white,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 50),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                     children: [
// //                       ScoreLabel(
// //                           icon: Icons.bar_chart,
// //                           label: "Accuracy",
// //                           value: "${widget.quiz.totalAccuracy}%"),
// //                       ScoreLabel(
// //                         icon: Icons.timer,
// //                         label: "Duration",
// //                         value: getformatTime(widget.duration),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 32),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                     children: [
// //                       ScoreLabel(
// //                           icon: Icons.remove_circle_outline,
// //                           label: "Skipped",
// //                           value: "${widget.quiz.totalSkippedQuestions}"),
// //                       ScoreLabel(
// //                           icon: Icons.cancel,
// //                           label: "Incorrect",
// //                           value: "${widget.quiz.totalIncorrectAnswers}"),
// //                     ],
// //                   ),
// //                   const Spacer(),
// //                   Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         ActionButton(
// //                             icon: Icons.refresh,
// //                             label: "Retry Quiz",
// //                             onPressed: () {
// //                               widget.onRetry();
// //                               Navigator.pop(context);
// //                             }),
// //                         ActionButton(
// //                             icon: Icons.check,
// //                             label: "Review Answer",
// //                             onPressed: () {
// //                               Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                   builder: (context) =>
// //                                       ReviewAnswer(quiz: widget.quiz),
// //                                 ),
// //                               );
// //                             }),
// //                         ActionButton(
// //                             icon: Icons.home,
// //                             label: "Home",
// //                             onPressed: () {
// //                               Navigator.of(context)
// //                                   .popUntil((route) => route.isFirst);
// //                             }),
// //                       ],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 24),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:quick_quiz/quick_quiz.dart';
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Quick Quiz Example'),
//         ),
//         body: Builder(
//           builder: (context) => Center(
//             child: TextButton(
//               child: const Text(
//                 "Play Quiz",
//                 style: TextStyle(fontSize: 16),
//               ),
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => QuizScreen(),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class QuizScreen extends StatelessWidget {
//   final quiz = Quiz(
//     questions: [
//       QuestionModel(
//         question:
//         'How is acceleration related to mass and force according to Newton\'s second law of motion?',
//         options: [
//           'Acceleration is directly proportional to mass and inversely proportional to force',
//           'Acceleration is directly proportional to force and mass',
//           'Acceleration is inversely proportional to mass and force',
//           'Acceleration is inversely proportional to force and directly proportional to mass'
//         ],
//         correctAnswerIndex: 0,
//       ),
//       QuestionModel(
//         question: 'What is the largest planet in our solar system?',
//         options: ['Earth', 'Jupiter', 'Mars', 'Saturn'],
//         correctAnswerIndex: 1,
//       ),
//       QuestionModel(
//         question: 'Which animal is known as the "King of the Jungle"?',
//         options: ['Tiger', 'Lion', 'Elephant', 'Bear'],
//         correctAnswerIndex: 1,
//       ),
//     ],
//     timerDuration: 30,
//   );
//
//   QuizScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Quiz'),
//         ),
//         body: QuizPage(quiz: quiz));
//   }
// }