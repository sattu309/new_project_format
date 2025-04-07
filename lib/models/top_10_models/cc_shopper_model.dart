class TopCCShopperModel {
  Success? success;

  TopCCShopperModel({this.success});

  TopCCShopperModel.fromJson(Map<String, dynamic> json) {
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
  String? monthstartdate;
  List<Topcctodayall>? topcctodayall;
  List<Topcc7daysall>? topcc7daysall;
  List<Topcc30daysall>? topcc30daysall;

  Success(
      {this.monthstartdate,
        this.topcctodayall,
        this.topcc7daysall,
        this.topcc30daysall});

  Success.fromJson(Map<String, dynamic> json) {
    monthstartdate = json['monthstartdate'];
    if (json['topcctodayall'] != null) {
      topcctodayall = <Topcctodayall>[];
      json['topcctodayall'].forEach((v) {
        topcctodayall!.add(new Topcctodayall.fromJson(v));
      });
    }
    if (json['topcc7daysall'] != null) {
      topcc7daysall = <Topcc7daysall>[];
      json['topcc7daysall'].forEach((v) {
        topcc7daysall!.add(new Topcc7daysall.fromJson(v));
      });
    }
    if (json['topcc30daysall'] != null) {
      topcc30daysall = <Topcc30daysall>[];
      json['topcc30daysall'].forEach((v) {
        topcc30daysall!.add(new Topcc30daysall.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthstartdate'] = this.monthstartdate;
    if (this.topcctodayall != null) {
      data['topcctodayall'] =
          this.topcctodayall!.map((v) => v.toJson()).toList();
    }
    if (this.topcc7daysall != null) {
      data['topcc7daysall'] =
          this.topcc7daysall!.map((v) => v.toJson()).toList();
    }
    if (this.topcc30daysall != null) {
      data['topcc30daysall'] =
          this.topcc30daysall!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topcctodayall {
  String? name;
  String? lname;
  String? email;
  String? totbuy;

  Topcctodayall({this.name, this.lname, this.email, this.totbuy});

  Topcctodayall.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lname = json['lname'];
    email = json['email'];
    totbuy = json['totbuy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['totbuy'] = this.totbuy;
    return data;
  }
}
class Topcc7daysall {
  String? name;
  String? lname;
  String? email;
  String? totbuy;

  Topcc7daysall({this.name, this.lname, this.email, this.totbuy});

  Topcc7daysall.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lname = json['lname'];
    email = json['email'];
    totbuy = json['totbuy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['totbuy'] = this.totbuy;
    return data;
  }
}
class Topcc30daysall {
  String? name;
  String? lname;
  String? email;
  String? totbuy;

  Topcc30daysall({this.name, this.lname, this.email, this.totbuy});

  Topcc30daysall.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lname = json['lname'];
    email = json['email'];
    totbuy = json['totbuy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['totbuy'] = this.totbuy;
    return data;
  }
}
