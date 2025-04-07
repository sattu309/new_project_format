class TopStoreShopperModel {
  Success? success;

  TopStoreShopperModel({this.success});

  TopStoreShopperModel.fromJson(Map<String, dynamic> json) {
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
  List<Topstoretodayall>? topstoretodayall;
  List<Topstore7daysall>? topstore7daysall;
  List<Topstore30daysall>? topstore30daysall;

  Success(
      {this.monthstartdate,
        this.topstoretodayall,
        this.topstore7daysall,
        this.topstore30daysall});

  Success.fromJson(Map<String, dynamic> json) {
    monthstartdate = json['monthstartdate'];
    if (json['topstoretodayall'] != null) {
      topstoretodayall = <Topstoretodayall>[];
      json['topstoretodayall'].forEach((v) {
        topstoretodayall!.add(new Topstoretodayall.fromJson(v));
      });
    }
    if (json['topstore7daysall'] != null) {
      topstore7daysall = <Topstore7daysall>[];
      json['topstore7daysall'].forEach((v) {
        topstore7daysall!.add(new Topstore7daysall.fromJson(v));
      });
    }
    if (json['topstore30daysall'] != null) {
      topstore30daysall = <Topstore30daysall>[];
      json['topstore30daysall'].forEach((v) {
        topstore30daysall!.add(new Topstore30daysall.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthstartdate'] = this.monthstartdate;
    if (this.topstoretodayall != null) {
      data['topstoretodayall'] =
          this.topstoretodayall!.map((v) => v.toJson()).toList();
    }
    if (this.topstore7daysall != null) {
      data['topstore7daysall'] =
          this.topstore7daysall!.map((v) => v.toJson()).toList();
    }
    if (this.topstore30daysall != null) {
      data['topstore30daysall'] =
          this.topstore30daysall!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topstoretodayall {
  String? name;
  String? lname;
  String? email;
  String? totbuy;

  Topstoretodayall({this.name, this.lname, this.email, this.totbuy});

  Topstoretodayall.fromJson(Map<String, dynamic> json) {
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
class Topstore7daysall {
  String? name;
  String? lname;
  String? email;
  String? totbuy;

  Topstore7daysall({this.name, this.lname, this.email, this.totbuy});

  Topstore7daysall.fromJson(Map<String, dynamic> json) {
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
class Topstore30daysall {
  String? name;
  String? lname;
  String? email;
  String? totbuy;

  Topstore30daysall({this.name, this.lname, this.email, this.totbuy});

  Topstore30daysall.fromJson(Map<String, dynamic> json) {
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
