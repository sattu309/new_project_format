class UserDetailsModel {
  String? token;
  int? id;
  String? name;
  String? lname;
  String? mobile;
  String? email;
  String? role;

  UserDetailsModel(
      {this.token,
        this.id,
        this.name,
        this.lname,
        this.mobile,
        this.email,
        this.role});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    lname = json['lname'];
    mobile = json['mobile'];
    email = json['email'];
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
    data['role'] = this.role;
    return data;
  }
}
