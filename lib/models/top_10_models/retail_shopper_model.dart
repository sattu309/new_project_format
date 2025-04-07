class TopRetailShopperModel {
  Success? success;

  TopRetailShopperModel({this.success});

  TopRetailShopperModel.fromJson(Map<String, dynamic> json) {
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
  List<Topcusttodayall>? topcusttodayall;
  List<Topcust7daysall>? topcust7daysall;
  List<Topcust30daysall>? topcust30daysall;

  Success(
      {this.monthstartdate,
        this.topcusttodayall,
        this.topcust7daysall,
        this.topcust30daysall});

  Success.fromJson(Map<String, dynamic> json) {
    monthstartdate = json['monthstartdate'];
    if (json['topcusttodayall'] != null) {
      topcusttodayall = <Topcusttodayall>[];
      json['topcusttodayall'].forEach((v) {
        topcusttodayall!.add(new Topcusttodayall.fromJson(v));
      });
    }
    if (json['topcust7daysall'] != null) {
      topcust7daysall = <Topcust7daysall>[];
      json['topcust7daysall'].forEach((v) {
        topcust7daysall!.add(new Topcust7daysall.fromJson(v));
      });
    }
    if (json['topcust30daysall'] != null) {
      topcust30daysall = <Topcust30daysall>[];
      json['topcust30daysall'].forEach((v) {
        topcust30daysall!.add(new Topcust30daysall.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthstartdate'] = this.monthstartdate;
    if (this.topcusttodayall != null) {
      data['topcusttodayall'] =
          this.topcusttodayall!.map((v) => v.toJson()).toList();
    }
    if (this.topcust7daysall != null) {
      data['topcust7daysall'] =
          this.topcust7daysall!.map((v) => v.toJson()).toList();
    }
    if (this.topcust30daysall != null) {
      data['topcust30daysall'] =
          this.topcust30daysall!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topcusttodayall {
  String? name;
  String? lname;
  String? email;
  String? totbuy;

  Topcusttodayall({this.name, this.lname, this.email, this.totbuy});

  Topcusttodayall.fromJson(Map<String, dynamic> json) {
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
class Topcust7daysall {
  String? name;
  String? lname;
  String? email;
  String? totbuy;

  Topcust7daysall({this.name, this.lname, this.email, this.totbuy});

  Topcust7daysall.fromJson(Map<String, dynamic> json) {
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
class Topcust30daysall {
  String? name;
  String? lname;
  String? email;
  String? totbuy;

  Topcust30daysall({this.name, this.lname, this.email, this.totbuy});

  Topcust30daysall.fromJson(Map<String, dynamic> json) {
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
