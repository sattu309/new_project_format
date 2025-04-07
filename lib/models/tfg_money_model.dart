class TFGMoneyModel {
  Success? success;

  TFGMoneyModel({this.success});

  TFGMoneyModel.fromJson(Map<String, dynamic> json) {
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
  Todaystoreordertfg? todaystoreordertfg;
  Todaystoreordertfg? todayretailordertfg;
  Todaystoreordertfg? todaycollectstoreordertfg;
  String? avgordvaltfg;

  Success(
      {this.todaystoreordertfg,
        this.todayretailordertfg,
        this.todaycollectstoreordertfg,
        this.avgordvaltfg});

  Success.fromJson(Map<String, dynamic> json) {
    todaystoreordertfg = json['todaystoreordertfg'] != null
        ? new Todaystoreordertfg.fromJson(json['todaystoreordertfg'])
        : null;
    todayretailordertfg = json['todayretailordertfg'] != null
        ? new Todaystoreordertfg.fromJson(json['todayretailordertfg'])
        : null;
    todaycollectstoreordertfg = json['todaycollectstoreordertfg'] != null
        ? new Todaystoreordertfg.fromJson(json['todaycollectstoreordertfg'])
        : null;
    avgordvaltfg = json['avgordvaltfg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.todaystoreordertfg != null) {
      data['todaystoreordertfg'] = this.todaystoreordertfg!.toJson();
    }
    if (this.todayretailordertfg != null) {
      data['todayretailordertfg'] = this.todayretailordertfg!.toJson();
    }
    if (this.todaycollectstoreordertfg != null) {
      data['todaycollectstoreordertfg'] =
          this.todaycollectstoreordertfg!.toJson();
    }
    data['avgordvaltfg'] = this.avgordvaltfg;
    return data;
  }
}

class Todaystoreordertfg {
  String? sumsubtotal;
  int? cnt;

  Todaystoreordertfg({this.sumsubtotal, this.cnt});

  Todaystoreordertfg.fromJson(Map<String, dynamic> json) {
    sumsubtotal = json['sumsubtotal'];
    cnt = json['cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sumsubtotal'] = this.sumsubtotal;
    data['cnt'] = this.cnt;
    return data;
  }
}
