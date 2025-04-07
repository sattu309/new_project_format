class TestResultModel {
  List<Success>? success;

  TestResultModel({this.success});

  TestResultModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = <Success>[];
      json['success'].forEach((v) {
        success!.add(new Success.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Success {
  dynamic id;
  dynamic categoryId;
  dynamic storeId;
  dynamic salesperson;
  dynamic startedOn;
  dynamic endedOn;
  dynamic markobtained;
  dynamic totalmarks;
  dynamic createdBy;
  dynamic createdAt;
  dynamic firstName;
  dynamic lastName;
  dynamic category;
  dynamic pdflink;

  Success(
      {this.id,
        this.categoryId,
        this.storeId,
        this.salesperson,
        this.startedOn,
        this.endedOn,
        this.markobtained,
        this.totalmarks,
        this.createdBy,
        this.createdAt,
        this.firstName,
        this.lastName,
        this.category,
        this.pdflink});

  Success.fromJson(Map<String, dynamic> json) {
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
    firstName = json['First_Name'];
    lastName = json['Last_Name'];
    category = json['category'];
    pdflink = json['pdflink'];
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
    data['First_Name'] = this.firstName;
    data['Last_Name'] = this.lastName;
    data['category'] = this.category;
    data['pdflink'] = this.pdflink;
    return data;
  }
}
