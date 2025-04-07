class PackageContentModel {
  dynamic success;
  List<Stockpending>? stockpending;
  List<Stockreceived>? stockreceived;

  PackageContentModel({this.success, this.stockpending, this.stockreceived});

  PackageContentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['stockpending'] != null) {
      stockpending = <Stockpending>[];
      json['stockpending'].forEach((v) {
        stockpending!.add(new Stockpending.fromJson(v));
      });
    }
    if (json['stockreceived'] != null) {
      stockreceived = <Stockreceived>[];
      json['stockreceived'].forEach((v) {
        stockreceived!.add(new Stockreceived.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.stockpending != null) {
      data['stockpending'] = this.stockpending!.map((v) => v.toJson()).toList();
    }
    if (this.stockreceived != null) {
      data['stockreceived'] =
          this.stockreceived!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stockpending {
  dynamic id;
  dynamic packageContent;
  dynamic packageCount;
  dynamic description;
  dynamic salesPerson;
  dynamic status;
  dynamic storeUserId;
  dynamic storecomment;
  dynamic createdBy;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic updatedBy;

  Stockpending(
      {this.id,
        this.packageContent,
        this.packageCount,
        this.description,
        this.salesPerson,
        this.status,
        this.storeUserId,
        this.storecomment,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.updatedBy});

  Stockpending.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageContent = json['package_content'];
    packageCount = json['package_count'];
    description = json['description'];
    salesPerson = json['sales_person'];
    status = json['status'];
    storeUserId = json['store_user_id'];
    storecomment = json['storecomment'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_content'] = this.packageContent;
    data['package_count'] = this.packageCount;
    data['description'] = this.description;
    data['sales_person'] = this.salesPerson;
    data['status'] = this.status;
    data['store_user_id'] = this.storeUserId;
    data['storecomment'] = this.storecomment;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

class Stockreceived {
  dynamic id;
  dynamic packageContent;
  dynamic packageCount;
  dynamic description;
  dynamic salesPerson;
  dynamic status;
  dynamic storeUserId;
  dynamic storecomment;
  dynamic createdBy;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic updatedBy;

  Stockreceived(
      {this.id,
        this.packageContent,
        this.packageCount,
        this.description,
        this.salesPerson,
        this.status,
        this.storeUserId,
        this.storecomment,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.updatedBy});

  Stockreceived.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageContent = json['package_content'];
    packageCount = json['package_count'];
    description = json['description'];
    salesPerson = json['sales_person'];
    status = json['status'];
    storeUserId = json['store_user_id'];
    storecomment = json['storecomment'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_content'] = this.packageContent;
    data['package_count'] = this.packageCount;
    data['description'] = this.description;
    data['sales_person'] = this.salesPerson;
    data['status'] = this.status;
    data['store_user_id'] = this.storeUserId;
    data['storecomment'] = this.storecomment;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
