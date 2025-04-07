class FurnitureRugsModel {
  Success? success;

  FurnitureRugsModel({this.success});

  FurnitureRugsModel.fromJson(Map<String, dynamic> json) {
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
  List<Ccorder>? ccorder;

  Success({this.monthstartdate, this.ccorder});

  Success.fromJson(Map<String, dynamic> json) {
    monthstartdate = json['monthstartdate'];
    if (json['ccorder'] != null) {
      ccorder = <Ccorder>[];
      json['ccorder'].forEach((v) {
        ccorder!.add(new Ccorder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthstartdate'] = this.monthstartdate;
    if (this.ccorder != null) {
      data['ccorder'] = this.ccorder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ccorder {
  String? productname;
  String? productcode;
  String? storename;
  String? totqty;
  String? totamount;

  Ccorder(
      {this.productname,
        this.productcode,
        this.storename,
        this.totqty,
        this.totamount});

  Ccorder.fromJson(Map<String, dynamic> json) {
    productname = json['productname'];
    productcode = json['productcode'];
    storename = json['storename'];
    totqty = json['totqty'];
    totamount = json['totamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productname'] = this.productname;
    data['productcode'] = this.productcode;
    data['storename'] = this.storename;
    data['totqty'] = this.totqty;
    data['totamount'] = this.totamount;
    return data;
  }
}
