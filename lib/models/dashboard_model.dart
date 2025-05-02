class DashboradModel {
  Success? success;

  DashboradModel({this.success});

  DashboradModel.fromJson(Map<String, dynamic> json) {
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
  dynamic yearstartdate;
  dynamic monthstartdate;
  Todaystoreorder? todaystoreorder;
  Todayretailorder? todayretailorder;
  Todaystoreorder? todaycollectstoreorder;
  dynamic avgordval;
  Todayretailorder? mtdallorders;
  Todayretailorder? ytdallorders;
  Todaystoreorder? yesterdayretailsales;
  dynamic salestarget;
  dynamic salestargetcol;
  dynamic todaycif;
  dynamic monthcif;

  Success(
      {this.yearstartdate,
        this.monthstartdate,
        this.todaystoreorder,
        this.todayretailorder,
        this.todaycollectstoreorder,
        this.avgordval,
        this.mtdallorders,
        this.ytdallorders,
        this.yesterdayretailsales,
        this.salestarget,
        this.salestargetcol,
        this.todaycif,
        this.monthcif
      });

  Success.fromJson(Map<String, dynamic> json) {
    yearstartdate = json['yearstartdate'];
    monthstartdate = json['monthstartdate'];
    todaystoreorder = json['todaystoreorder'] != null
        ? new Todaystoreorder.fromJson(json['todaystoreorder'])
        : null;
    todayretailorder = json['todayretailorder'] != null
        ? new Todayretailorder.fromJson(json['todayretailorder'])
        : null;
    todaycollectstoreorder = json['todaycollectstoreorder'] != null
        ? new Todaystoreorder.fromJson(json['todaycollectstoreorder'])
        : null;
    avgordval = json['avgordval'];
    mtdallorders = json['mtdallorders'] != null
        ? new Todayretailorder.fromJson(json['mtdallorders'])
        : null;
    ytdallorders = json['ytdallorders'] != null
        ? new Todayretailorder.fromJson(json['ytdallorders'])
        : null;
    yesterdayretailsales = json['yesterdayretailsales'] != null
        ? Todaystoreorder.fromJson(json['yesterdayretailsales'])
        : null;
    salestarget = json['salestarget'];
    salestargetcol = json['salestargetcol'];
    todaycif = json['todaycif'];
    monthcif = json['monthcif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yearstartdate'] = this.yearstartdate;
    data['monthstartdate'] = this.monthstartdate;
    if (this.todaystoreorder != null) {
      data['todaystoreorder'] = this.todaystoreorder!.toJson();
    }
    if (this.todayretailorder != null) {
      data['todayretailorder'] = this.todayretailorder!.toJson();
    }
    if (this.todaycollectstoreorder != null) {
      data['todaycollectstoreorder'] = this.todaycollectstoreorder!.toJson();
    }
    data['avgordval'] = this.avgordval;
    if (this.mtdallorders != null) {
      data['mtdallorders'] = this.mtdallorders!.toJson();
    }
    if (this.ytdallorders != null) {
      data['ytdallorders'] = this.ytdallorders!.toJson();
    }
    if (this.yesterdayretailsales != null) {
      data['yesterdayretailsales'] = this.yesterdayretailsales!.toJson();
    }
    data['salestarget'] = this.salestarget;
    data['salestargetcol'] = this.salestargetcol;
    data['todaycif'] = this.todaycif;
    data['monthcif'] = this.monthcif;
    return data;
  }
}

class Todaystoreorder {
   dynamic sumsubtotal;
  dynamic cnt;

  Todaystoreorder({this.sumsubtotal, this.cnt});

  Todaystoreorder.fromJson(Map<String, dynamic> json) {
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
