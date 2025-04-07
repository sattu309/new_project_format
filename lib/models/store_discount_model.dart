class StoreDiscountModel {
  Success? success;

  StoreDiscountModel({this.success});

  StoreDiscountModel.fromJson(Map<String, dynamic> json) {
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
  List<Promodata>? promodata;

  Success({this.promodata});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['promodata'] != null) {
      promodata = <Promodata>[];
      json['promodata'].forEach((v) {
        promodata!.add(new Promodata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.promodata != null) {
      data['promodata'] = this.promodata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Promodata {
  dynamic discounttype;
  dynamic title;
  dynamic discountvalue;
  dynamic startdate;
  dynamic enddate;
  dynamic applyon;

  Promodata(
      {this.discounttype,
        this.title,
        this.discountvalue,
        this.startdate,
        this.enddate,
        this.applyon});

  Promodata.fromJson(Map<String, dynamic> json) {
    discounttype = json['discounttype'];
    title = json['title'];
    discountvalue = json['discountvalue'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    applyon = json['applyon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discounttype'] = this.discounttype;
    data['title'] = this.title;
    data['discountvalue'] = this.discountvalue;
    data['startdate'] = this.startdate;
    data['enddate'] = this.enddate;
    data['applyon'] = this.applyon;
    return data;
  }
}
