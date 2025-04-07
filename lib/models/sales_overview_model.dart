class SalesOverViewModel {
  Success? success;

  SalesOverViewModel({this.success});

  SalesOverViewModel.fromJson(Map<String, dynamic> json) {
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
  Todayretailorder? todayretailorder;
  Todayretailorder? todaystoreorder;
  Todayretailorder? todaycollectstoreorder;
  Todayretailorder? yesterdayretailorder;
  Todayretailorder? yesterdaystoreorder;
  Todayretailorder? yesterdaycollectstoreorder;
  Todayretailorder? dbyesterdayretailorder;
  Todayretailorder? dbyesterdaystoreorder;
  Todayretailorder? dbyesterdaycollectstoreorder;
  Todayretailorder? db2yesterdayretailorder;
  Todayretailorder? db2yesterdaystoreorder;
  Todayretailorder? db2yesterdaycollectstoreorder;
  Todayretailorder? day7retailorder;
  Todayretailorder? day7storeorder;
  Todayretailorder? day7collectstoreorder;
  Todayretailorder? day30retailorder;
  Todayretailorder? day30storeorder;
  Todayretailorder? day30collectstoreorder;
  String? monthstartdate;

  Success(
      {this.todayretailorder,
        this.todaystoreorder,
        this.todaycollectstoreorder,
        this.yesterdayretailorder,
        this.yesterdaystoreorder,
        this.yesterdaycollectstoreorder,
        this.dbyesterdayretailorder,
        this.dbyesterdaystoreorder,
        this.dbyesterdaycollectstoreorder,
        this.db2yesterdayretailorder,
        this.db2yesterdaystoreorder,
        this.db2yesterdaycollectstoreorder,
        this.day7retailorder,
        this.day7storeorder,
        this.day7collectstoreorder,
        this.day30retailorder,
        this.day30storeorder,
        this.day30collectstoreorder,
        this.monthstartdate});

  Success.fromJson(Map<String, dynamic> json) {
    todayretailorder = json['todayretailorder'] != null
        ? new Todayretailorder.fromJson(json['todayretailorder'])
        : null;
    todaystoreorder = json['todaystoreorder'] != null
        ? new Todayretailorder.fromJson(json['todaystoreorder'])
        : null;
    todaycollectstoreorder = json['todaycollectstoreorder'] != null
        ? new Todayretailorder.fromJson(json['todaycollectstoreorder'])
        : null;
    yesterdayretailorder = json['yesterdayretailorder'] != null
        ? new Todayretailorder.fromJson(json['yesterdayretailorder'])
        : null;
    yesterdaystoreorder = json['yesterdaystoreorder'] != null
        ? new Todayretailorder.fromJson(json['yesterdaystoreorder'])
        : null;
    yesterdaycollectstoreorder = json['yesterdaycollectstoreorder'] != null
        ? new Todayretailorder.fromJson(json['yesterdaycollectstoreorder'])
        : null;
    dbyesterdayretailorder = json['dbyesterdayretailorder'] != null
        ? new Todayretailorder.fromJson(json['dbyesterdayretailorder'])
        : null;
    dbyesterdaystoreorder = json['dbyesterdaystoreorder'] != null
        ? new Todayretailorder.fromJson(json['dbyesterdaystoreorder'])
        : null;
    dbyesterdaycollectstoreorder = json['dbyesterdaycollectstoreorder'] != null
        ? new Todayretailorder.fromJson(json['dbyesterdaycollectstoreorder'])
        : null;
    db2yesterdayretailorder = json['db2yesterdayretailorder'] != null
        ? new Todayretailorder.fromJson(json['db2yesterdayretailorder'])
        : null;
    db2yesterdaystoreorder = json['db2yesterdaystoreorder'] != null
        ? new Todayretailorder.fromJson(json['db2yesterdaystoreorder'])
        : null;
    db2yesterdaycollectstoreorder = json['db2yesterdaycollectstoreorder'] !=
        null
        ? new Todayretailorder.fromJson(json['db2yesterdaycollectstoreorder'])
        : null;
    day7retailorder = json['day7retailorder'] != null
        ? new Todayretailorder.fromJson(json['day7retailorder'])
        : null;
    day7storeorder = json['day7storeorder'] != null
        ? new Todayretailorder.fromJson(json['day7storeorder'])
        : null;
    day7collectstoreorder = json['day7collectstoreorder'] != null
        ? new Todayretailorder.fromJson(json['day7collectstoreorder'])
        : null;
    day30retailorder = json['day30retailorder'] != null
        ? new Todayretailorder.fromJson(json['day30retailorder'])
        : null;
    day30storeorder = json['day30storeorder'] != null
        ? new Todayretailorder.fromJson(json['day30storeorder'])
        : null;
    day30collectstoreorder = json['day30collectstoreorder'] != null
        ? new Todayretailorder.fromJson(json['day30collectstoreorder'])
        : null;
    monthstartdate = json['monthstartdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.todayretailorder != null) {
      data['todayretailorder'] = this.todayretailorder!.toJson();
    }
    if (this.todaystoreorder != null) {
      data['todaystoreorder'] = this.todaystoreorder!.toJson();
    }
    if (this.todaycollectstoreorder != null) {
      data['todaycollectstoreorder'] = this.todaycollectstoreorder!.toJson();
    }
    if (this.yesterdayretailorder != null) {
      data['yesterdayretailorder'] = this.yesterdayretailorder!.toJson();
    }
    if (this.yesterdaystoreorder != null) {
      data['yesterdaystoreorder'] = this.yesterdaystoreorder!.toJson();
    }
    if (this.yesterdaycollectstoreorder != null) {
      data['yesterdaycollectstoreorder'] =
          this.yesterdaycollectstoreorder!.toJson();
    }
    if (this.dbyesterdayretailorder != null) {
      data['dbyesterdayretailorder'] = this.dbyesterdayretailorder!.toJson();
    }
    if (this.dbyesterdaystoreorder != null) {
      data['dbyesterdaystoreorder'] = this.dbyesterdaystoreorder!.toJson();
    }
    if (this.dbyesterdaycollectstoreorder != null) {
      data['dbyesterdaycollectstoreorder'] =
          this.dbyesterdaycollectstoreorder!.toJson();
    }
    if (this.db2yesterdayretailorder != null) {
      data['db2yesterdayretailorder'] = this.db2yesterdayretailorder!.toJson();
    }
    if (this.db2yesterdaystoreorder != null) {
      data['db2yesterdaystoreorder'] = this.db2yesterdaystoreorder!.toJson();
    }
    if (this.db2yesterdaycollectstoreorder != null) {
      data['db2yesterdaycollectstoreorder'] =
          this.db2yesterdaycollectstoreorder!.toJson();
    }
    if (this.day7retailorder != null) {
      data['day7retailorder'] = this.day7retailorder!.toJson();
    }
    if (this.day7storeorder != null) {
      data['day7storeorder'] = this.day7storeorder!.toJson();
    }
    if (this.day7collectstoreorder != null) {
      data['day7collectstoreorder'] = this.day7collectstoreorder!.toJson();
    }
    if (this.day30retailorder != null) {
      data['day30retailorder'] = this.day30retailorder!.toJson();
    }
    if (this.day30storeorder != null) {
      data['day30storeorder'] = this.day30storeorder!.toJson();
    }
    if (this.day30collectstoreorder != null) {
      data['day30collectstoreorder'] = this.day30collectstoreorder!.toJson();
    }
    data['monthstartdate'] = this.monthstartdate;
    return data;
  }
}

class Todayretailorder {
  dynamic sumsubtotal;
  dynamic cnt;

  Todayretailorder({this.sumsubtotal, this.cnt});

  Todayretailorder.fromJson(Map<String, dynamic> json) {
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
