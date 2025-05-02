class QuizResultDataDisplay {
  Success? success;
  Quizresult? quizresult;
  List<TestResults>? testResults;

  QuizResultDataDisplay({this.success, this.quizresult, this.testResults});

  QuizResultDataDisplay.fromJson(Map<String, dynamic> json) {
    success =
    json['success'] != null ? new Success.fromJson(json['success']) : null;
    quizresult = json['quizresult'] != null
        ? new Quizresult.fromJson(json['quizresult'])
        : null;
    if (json['testResults'] != null) {
      testResults = <TestResults>[];
      json['testResults'].forEach((v) {
        testResults!.add(new TestResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success!.toJson();
    }
    if (this.quizresult != null) {
      data['quizresult'] = this.quizresult!.toJson();
    }
    if (this.testResults != null) {
      data['testResults'] = this.testResults!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Success {
  QuizData? quizData;

  Success({this.quizData});

  Success.fromJson(Map<String, dynamic> json) {
    quizData = json['quizData'] != null
        ? new QuizData.fromJson(json['quizData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quizData != null) {
      data['quizData'] = this.quizData!.toJson();
    }
    return data;
  }
}

class QuizData {
  int? id;
  int? categoryId;
  int? storeId;
  String? salesperson;
  String? startedOn;
  String? endedOn;
  int? markobtained;
  int? totalmarks;
  int? createdBy;
  String? createdAt;

  QuizData(
      {this.id,
        this.categoryId,
        this.storeId,
        this.salesperson,
        this.startedOn,
        this.endedOn,
        this.markobtained,
        this.totalmarks,
        this.createdBy,
        this.createdAt});

  QuizData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    storeId = json['store_id'];
    salesperson = json['salesperson'];
    startedOn = json['started_on'];
    endedOn = json['ended_on'];
    markobtained = json['markobtained'];
    totalmarks = json['totalmarks'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['store_id'] = this.storeId;
    data['salesperson'] = this.salesperson;
    data['started_on'] = this.startedOn;
    data['ended_on'] = this.endedOn;
    data['markobtained'] = this.markobtained;
    data['totalmarks'] = this.totalmarks;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Quizresult {
  int? markobtained;
  int? totalmarks;
  String? storeName;
  String? firstName;
  String? lastName;

  Quizresult(
      {this.markobtained,
        this.totalmarks,
        this.storeName,
        this.firstName,
        this.lastName});

  Quizresult.fromJson(Map<String, dynamic> json) {
    markobtained = json['markobtained'];
    totalmarks = json['totalmarks'];
    storeName = json['Store_Name'];
    firstName = json['First_Name'];
    lastName = json['Last_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['markobtained'] = this.markobtained;
    data['totalmarks'] = this.totalmarks;
    data['Store_Name'] = this.storeName;
    data['First_Name'] = this.firstName;
    data['Last_Name'] = this.lastName;
    return data;
  }
}

class TestResults {
  int? categoryId;
  String? correctoption;
  int? id;
  int? isCorrect;
  int? isCorrect1;
  int? isCorrect2;
  int? isCorrect3;
  int? isCorrect4;
  int? markobtained;
  int? marks;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? question;
  Selectedanswers? selectedanswers;

  TestResults(
      {this.categoryId,
        this.correctoption,
        this.id,
        this.isCorrect,
        this.isCorrect1,
        this.isCorrect2,
        this.isCorrect3,
        this.isCorrect4,
        this.markobtained,
        this.marks,
        this.option1,
        this.option2,
        this.option3,
        this.option4,
        this.question,
        this.selectedanswers});

  TestResults.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    correctoption = json['correctoption'];
    id = json['id'];
    isCorrect = json['is_correct'];
    isCorrect1 = json['is_correct1'];
    isCorrect2 = json['is_correct2'];
    isCorrect3 = json['is_correct3'];
    isCorrect4 = json['is_correct4'];
    markobtained = json['markobtained'];
    marks = json['marks'];
    option1 = json['option1'];
    option2 = json['option2'];
    option3 = json['option3'];
    option4 = json['option4'];
    question = json['question'];
    selectedanswers = json['selectedanswers'] != null
        ? new Selectedanswers.fromJson(json['selectedanswers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['correctoption'] = this.correctoption;
    data['id'] = this.id;
    data['is_correct'] = this.isCorrect;
    data['is_correct1'] = this.isCorrect1;
    data['is_correct2'] = this.isCorrect2;
    data['is_correct3'] = this.isCorrect3;
    data['is_correct4'] = this.isCorrect4;
    data['markobtained'] = this.markobtained;
    data['marks'] = this.marks;
    data['option1'] = this.option1;
    data['option2'] = this.option2;
    data['option3'] = this.option3;
    data['option4'] = this.option4;
    data['question'] = this.question;
    if (this.selectedanswers != null) {
      data['selectedanswers'] = this.selectedanswers!.toJson();
    }
    return data;
  }
}

class Selectedanswers {
  int? option1;
  int? option2;
  int? option3;
  int? option4;

  Selectedanswers({this.option1, this.option2, this.option3, this.option4});

  Selectedanswers.fromJson(Map<String, dynamic> json) {
    option1 = json['option1'];
    option2 = json['option2'];
    option3 = json['option3'];
    option4 = json['option4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option1'] = this.option1;
    data['option2'] = this.option2;
    data['option3'] = this.option3;
    data['option4'] = this.option4;
    return data;
  }
}
