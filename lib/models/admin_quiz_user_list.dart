class QuizUserListModel {
  Success? success;

  QuizUserListModel({this.success});

  QuizUserListModel.fromJson(Map<String, dynamic> json) {
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
  List<Salespersons>? salespersons;
  List<Categories>? categories;

  Success({this.salespersons, this.categories});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['salespersons'] != null) {
      salespersons = <Salespersons>[];
      json['salespersons'].forEach((v) {
        salespersons!.add(new Salespersons.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.salespersons != null) {
      data['salespersons'] = this.salespersons!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Salespersons {
  String? key;
  String? iD;
  String? firstName;
  String? lastName;
  String? salesPerson;
  String? storeNo;
  String? storeName;

  Salespersons(
      {this.key,
        this.iD,
        this.firstName,
        this.lastName,
        this.salesPerson,
        this.storeNo,
        this.storeName});

  Salespersons.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    iD = json['ID'];
    firstName = json['First_Name'];
    lastName = json['Last_Name'];
    salesPerson = json['Sales_Person'];
    storeNo = json['Store_No'];
    storeName = json['Store_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Key'] = this.key;
    data['ID'] = this.iD;
    data['First_Name'] = this.firstName;
    data['Last_Name'] = this.lastName;
    data['Sales_Person'] = this.salesPerson;
    data['Store_No'] = this.storeNo;
    data['Store_Name'] = this.storeName;
    return data;
  }
}

class Categories {
  int? id;
  String? category;
  int? isActive;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Categories(
      {this.id,
        this.category,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['is_active'] = this.isActive;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
