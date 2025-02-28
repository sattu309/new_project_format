class VerifyOtpModel {
  Success? success;

  VerifyOtpModel({this.success});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
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
  dynamic token;
  dynamic id;
  String? name;
  String? lname;
  String? mobile;
  String? email;
  List<Null>? coupons;
  String? role;

  Success(
      {this.token,
        this.id,
        this.name,
        this.lname,
        this.mobile,
        this.email,
        this.coupons,
        this.role});

  Success.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    lname = json['lname'];
    mobile = json['mobile'];
    email = json['email'];
    // if (json['coupons'] != null) {
    //   coupons = <Null>[];
    //   json['coupons'].forEach((v) {
    //     coupons!.add(new Null.fromJson(v));
    //   });
    // }
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['name'] = this.name;
    data['lname'] = this.lname;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    // if (this.coupons != null) {
    //   data['coupons'] = this.coupons!.map((v) => v.toJson()).toList();
    // }
    data['role'] = this.role;
    return data;
  }
}
