// class Quiz {
//   final List<QuestionModel> questions;
//   int? timerDuration = 120;
//
//   Quiz({
//     required this.questions,
//     this.timerDuration,
//   });
//
//   /// Getter for total number of questions
//   int get totalQuestions => questions.length;
//
//   /// Calculates the total number of skipped questions
//   int get totalSkippedQuestions {
//     return questions
//         .where((question) => question.selectedAnswerIndex == null)
//         .length;
//   }
//
//   /// Calculates the total number of correct answers
//   int get totalCorrectAnswers {
//     return questions
//         .where((question) =>
//     question.selectedAnswerIndex == question.correctAnswerIndex)
//         .length;
//   }
//
//   /// Calculates the total number of incorrect answers
//   int get totalIncorrectAnswers {
//     return questions
//         .where((question) =>
//     question.selectedAnswerIndex != null &&
//         question.selectedAnswerIndex != question.correctAnswerIndex)
//         .length;
//   }
//
//   /// Calculates the accuracy as a percentage
//   int get totalAccuracy {
//     return ((totalCorrectAnswers / totalQuestions) * 100).toInt();
//   }
// }
//
// class QuestionModel {
//   /// Question
//   final String question;
//
//   /// List of options
//   final List<String> options;
//
//   /// Indices of correct answers in options list
//   final List<int> correctAnswerIndex;
//
//   /// Indices of user's selected answers. Empty if no answer is selected
//   List<int> selectedAnswerIndex;
//
//   /// Constructor
//   QuestionModel({
//     required this.question,
//     required this.options,
//     required this.correctAnswerIndex,
//     List<int>? selectedAnswerIndex,
//   }) : selectedAnswerIndex = selectedAnswerIndex ?? [] {
//     setCorrectAnswerIndex(correctAnswerIndex);
//   }
//
//   void setCorrectAnswerIndex(List<int> indices) {
//     for (var index in indices) {
//       if (index < 0 || index >= options.length) {
//         throw ArgumentError(
//             "Each correct answer index of question \n\"$question\"\nmust be within the range of available options.");
//       }
//     }
//   }
// }
