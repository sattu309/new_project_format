class TopStoreShopperOverAllModel {
  Success? success;

  TopStoreShopperOverAllModel({this.success});

  TopStoreShopperOverAllModel.fromJson(Map<String, dynamic> json) {
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
  List<Top10store>? top10store;

  Success({this.top10store});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['top10store'] != null) {
      top10store = <Top10store>[];
      json['top10store'].forEach((v) {
        top10store!.add(new Top10store.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.top10store != null) {
      data['top10store'] = this.top10store!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Top10store {
  String? totamount;
  int? cnt;
  int? userId;
  String? name;
  String? email;

  Top10store({this.totamount, this.cnt, this.userId, this.name, this.email});

  Top10store.fromJson(Map<String, dynamic> json) {
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
