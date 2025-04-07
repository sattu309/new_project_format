class LeaderBoardModel {
  List<Success>? success;

  LeaderBoardModel({this.success});

  LeaderBoardModel.fromJson(Map<String, dynamic> json) {
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
  dynamic storename;
  dynamic salesperson;
  dynamic totattempts;
  dynamic avgRight;
  dynamic maxmarkobtained;
  dynamic topleader;

  Success(
      {this.id,
        this.storename,
        this.salesperson,
        this.totattempts,
        this.avgRight,
        this.maxmarkobtained,
        this.topleader});

  Success.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storename = json['storename'];
    salesperson = json['salesperson'];
    totattempts = json['totattempts'];
    avgRight = json['AvgRight'];
    maxmarkobtained = json['maxmarkobtained'];
    topleader = json['topleader'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['storename'] = this.storename;
    data['salesperson'] = this.salesperson;
    data['totattempts'] = this.totattempts;
    data['AvgRight'] = this.avgRight;
    data['maxmarkobtained'] = this.maxmarkobtained;
    data['topleader'] = this.topleader;
    return data;
  }
}
