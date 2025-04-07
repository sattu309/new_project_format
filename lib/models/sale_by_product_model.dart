class SaleByProdcutModel {
  Success? success;

  SaleByProdcutModel({this.success});

  SaleByProdcutModel.fromJson(Map<String, dynamic> json) {
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
  String? yearstartdate;
  String? monthstartdate;
  List<Topseller30days>? topseller30days;
  List<Topsellertoday>? topsellertoday;
  List<Topseller7days>? topseller7days;

  Success(
      {this.yearstartdate,
        this.monthstartdate,
        this.topseller30days,
        this.topsellertoday,
        this.topseller7days});

  Success.fromJson(Map<String, dynamic> json) {
    yearstartdate = json['yearstartdate'];
    monthstartdate = json['monthstartdate'];
    if (json['topseller30days'] != null) {
      topseller30days = <Topseller30days>[];
      json['topseller30days'].forEach((v) {
        topseller30days!.add(new Topseller30days.fromJson(v));
      });
    }
    if (json['topsellertoday'] != null) {
      topsellertoday = <Topsellertoday>[];
      json['topsellertoday'].forEach((v) {
        topsellertoday!.add(new Topsellertoday.fromJson(v));
      });
    }
    if (json['topseller7days'] != null) {
      topseller7days = <Topseller7days>[];
      json['topseller7days'].forEach((v) {
        topseller7days!.add(new Topseller7days.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yearstartdate'] = this.yearstartdate;
    data['monthstartdate'] = this.monthstartdate;
    if (this.topseller30days != null) {
      data['topseller30days'] =
          this.topseller30days!.map((v) => v.toJson()).toList();
    }
    if (this.topsellertoday != null) {
      data['topsellertoday'] =
          this.topsellertoday!.map((v) => v.toJson()).toList();
    }
    if (this.topseller7days != null) {
      data['topseller7days'] =
          this.topseller7days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topseller30days {
  dynamic productname;
  dynamic retailsell;
  dynamic storesell;
  dynamic ccsell;
  dynamic totsell;

  Topseller30days(
      {this.productname,
        this.retailsell,
        this.storesell,
        this.ccsell,
        this.totsell});

  Topseller30days.fromJson(Map<String, dynamic> json) {
    productname = json['productname'];
    retailsell = json['retailsell'];
    storesell = json['storesell'];
    ccsell = json['ccsell'];
    totsell = json['totsell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productname'] = this.productname;
    data['retailsell'] = this.retailsell;
    data['storesell'] = this.storesell;
    data['ccsell'] = this.ccsell;
    data['totsell'] = this.totsell;
    return data;
  }
}
class Topsellertoday {
  dynamic productname;
  dynamic retailsell;
  dynamic storesell;
  dynamic ccsell;
  dynamic totsell;

  Topsellertoday(
      {this.productname,
        this.retailsell,
        this.storesell,
        this.ccsell,
        this.totsell});

  Topsellertoday.fromJson(Map<String, dynamic> json) {
    productname = json['productname'];
    retailsell = json['retailsell'];
    storesell = json['storesell'];
    ccsell = json['ccsell'];
    totsell = json['totsell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productname'] = this.productname;
    data['retailsell'] = this.retailsell;
    data['storesell'] = this.storesell;
    data['ccsell'] = this.ccsell;
    data['totsell'] = this.totsell;
    return data;
  }
}
class Topseller7days {
  dynamic productname;
  dynamic retailsell;
  dynamic storesell;
  dynamic ccsell;
  dynamic totsell;

  Topseller7days(
      {this.productname,
        this.retailsell,
        this.storesell,
        this.ccsell,
        this.totsell});

  Topseller7days.fromJson(Map<String, dynamic> json) {
    productname = json['productname'];
    retailsell = json['retailsell'];
    storesell = json['storesell'];
    ccsell = json['ccsell'];
    totsell = json['totsell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productname'] = this.productname;
    data['retailsell'] = this.retailsell;
    data['storesell'] = this.storesell;
    data['ccsell'] = this.ccsell;
    data['totsell'] = this.totsell;
    return data;
  }
}
