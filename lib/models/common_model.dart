class CommonModel {
  dynamic success;

  CommonModel({this.success});

  CommonModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    return data;
  }
}
class PlaceOrderModel {
  String? success;
  String? orderid;

  PlaceOrderModel({this.success, this.orderid});

  PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    orderid = json['orderid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['orderid'] = this.orderid;
    return data;
  }
}

