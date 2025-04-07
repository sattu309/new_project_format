class TopCCSaleStoreModel {
  Success? success;

  TopCCSaleStoreModel({this.success});

  TopCCSaleStoreModel.fromJson(Map<String, dynamic> json) {
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
  List<Topccstoretodayall>? topccstoretodayall;
  List<Topccstore7daysall>? topccstore7daysall;
  List<Topccstore30daysall>? topccstore30daysall;

  Success(
      {this.monthstartdate,
        this.topccstoretodayall,
        this.topccstore7daysall,
        this.topccstore30daysall});

  Success.fromJson(Map<String, dynamic> json) {
    monthstartdate = json['monthstartdate'];
    if (json['topccstoretodayall'] != null) {
      topccstoretodayall = <Topccstoretodayall>[];
      json['topccstoretodayall'].forEach((v) {
        topccstoretodayall!.add(new Topccstoretodayall.fromJson(v));
      });
    }
    if (json['topccstore7daysall'] != null) {
      topccstore7daysall = <Topccstore7daysall>[];
      json['topccstore7daysall'].forEach((v) {
        topccstore7daysall!.add(new Topccstore7daysall.fromJson(v));
      });
    }
    if (json['topccstore30daysall'] != null) {
      topccstore30daysall = <Topccstore30daysall>[];
      json['topccstore30daysall'].forEach((v) {
        topccstore30daysall!.add(new Topccstore30daysall.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthstartdate'] = this.monthstartdate;
    if (this.topccstoretodayall != null) {
      data['topccstoretodayall'] =
          this.topccstoretodayall!.map((v) => v.toJson()).toList();
    }
    if (this.topccstore7daysall != null) {
      data['topccstore7daysall'] =
          this.topccstore7daysall!.map((v) => v.toJson()).toList();
    }
    if (this.topccstore30daysall != null) {
      data['topccstore30daysall'] =
          this.topccstore30daysall!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topccstoretodayall {
  String? storename;
  String? totbuy;
  int? totord;

  Topccstoretodayall({this.storename, this.totbuy, this.totord});

  Topccstoretodayall.fromJson(Map<String, dynamic> json) {
    storename = json['storename'];
    totbuy = json['totbuy'];
    totord = json['totord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storename'] = this.storename;
    data['totbuy'] = this.totbuy;
    data['totord'] = this.totord;
    return data;
  }
}
class Topccstore7daysall {
  String? storename;
  String? totbuy;
  int? totord;

  Topccstore7daysall({this.storename, this.totbuy, this.totord});

  Topccstore7daysall.fromJson(Map<String, dynamic> json) {
    storename = json['storename'];
    totbuy = json['totbuy'];
    totord = json['totord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storename'] = this.storename;
    data['totbuy'] = this.totbuy;
    data['totord'] = this.totord;
    return data;
  }
}
class Topccstore30daysall {
  String? storename;
  String? totbuy;
  int? totord;

  Topccstore30daysall({this.storename, this.totbuy, this.totord});

  Topccstore30daysall.fromJson(Map<String, dynamic> json) {
    storename = json['storename'];
    totbuy = json['totbuy'];
    totord = json['totord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storename'] = this.storename;
    data['totbuy'] = this.totbuy;
    data['totord'] = this.totord;
    return data;
  }
}
