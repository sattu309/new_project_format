class FiftyRetailShoopersModel {
  Success? success;

  FiftyRetailShoopersModel({this.success});

  FiftyRetailShoopersModel.fromJson(Map<String, dynamic> json) {
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
  List<Top50cust>? top50cust;

  Success({this.top50cust});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['top50cust'] != null) {
      top50cust = <Top50cust>[];
      json['top50cust'].forEach((v) {
        top50cust!.add(new Top50cust.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.top50cust != null) {
      data['top50cust'] = this.top50cust!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Top50cust {
  String? totamount;
  int? cnt;
  int? userId;
  String? name;
  String? email;

  Top50cust({this.totamount, this.cnt, this.userId, this.name, this.email});

  Top50cust.fromJson(Map<String, dynamic> json) {
    totamount = json['totamount'];
    cnt = json['cnt'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totamount'] = this.totamount;
    data['cnt'] = this.cnt;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
