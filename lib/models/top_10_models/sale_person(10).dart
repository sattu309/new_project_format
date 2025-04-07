class TopTenSalesPersonModel {
  Success? success;

  TopTenSalesPersonModel({this.success});

  TopTenSalesPersonModel.fromJson(Map<String, dynamic> json) {
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
  List<Top10salespeople>? top10salespeople;

  Success({this.top10salespeople});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['top10salespeople'] != null) {
      top10salespeople = <Top10salespeople>[];
      json['top10salespeople'].forEach((v) {
        top10salespeople!.add(new Top10salespeople.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.top10salespeople != null) {
      data['top10salespeople'] =
          this.top10salespeople!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Top10salespeople {
  String? totamount;
  int? cnt;
  String? firstName;
  String? lastName;
  String? storeName;

  Top10salespeople(
      {this.totamount,
        this.cnt,
        this.firstName,
        this.lastName,
        this.storeName});

  Top10salespeople.fromJson(Map<String, dynamic> json) {
    totamount = json['totamount'];
    cnt = json['cnt'];
    firstName = json['First_Name'];
    lastName = json['Last_Name'];
    storeName = json['Store_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totamount'] = this.totamount;
    data['cnt'] = this.cnt;
    data['First_Name'] = this.firstName;
    data['Last_Name'] = this.lastName;
    data['Store_Name'] = this.storeName;
    return data;
  }
}
