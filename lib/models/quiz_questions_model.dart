class QuizQuestionsModel {
  Success? success;

  QuizQuestionsModel({this.success});

  QuizQuestionsModel.fromJson(Map<String, dynamic> json) {
    success =
    json['success'] != null ? new Success.fromJson(json['success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success!.toJson();
    }
    return data;
  }
}

class Success {
  List<Questionsdata>? questionsdata;

  Success({this.questionsdata});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['questionsdata'] != null) {
      questionsdata = <Questionsdata>[];
      json['questionsdata'].forEach((v) {
        questionsdata!.add(new Questionsdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questionsdata != null) {
      data['questionsdata'] =
          this.questionsdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questionsdata {
  dynamic questionId;
  dynamic question;
  List<String>? responses;
  List<String>? answers;

  Questionsdata({this.questionId, this.question, this.responses, this.answers});

  Questionsdata.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    question = json['question'];
    responses = json['responses'].cast<String>();
    answers = json['answers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['question'] = this.question;
    data['responses'] = this.responses;
    data['answers'] = this.answers;
    return data;
  }
}
