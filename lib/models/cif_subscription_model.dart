class CifSubscriptionModel {
  Success? success;

  CifSubscriptionModel({this.success});

  CifSubscriptionModel.fromJson(Map<String, dynamic> json) {
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
  List<Storecifdata>? storecifdata;

  Success({this.storecifdata});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['storecifdata'] != null) {
      storecifdata = <Storecifdata>[];
      json['storecifdata'].forEach((v) {
        storecifdata!.add(new Storecifdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.storecifdata != null) {
      data['storecifdata'] = this.storecifdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Storecifdata {
  dynamic storename;
  dynamic todaycif;
  dynamic monthcif;

  Storecifdata({this.storename, this.todaycif, this.monthcif});

  Storecifdata.fromJson(Map<String, dynamic> json) {
    storename = json['storename'];
    todaycif = json['todaycif'];
    monthcif = json['monthcif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storename'] = this.storename;
    data['todaycif'] = this.todaycif;
    data['monthcif'] = this.monthcif;
    return data;
  }
}
