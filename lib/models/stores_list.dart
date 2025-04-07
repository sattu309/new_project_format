class GetStoreListModel {
  Success? success;

  GetStoreListModel({this.success});

  GetStoreListModel.fromJson(Map<String, dynamic> json) {
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
  List<Documents>? documents;
  String? documentlink;

  Success({this.documents, this.documentlink});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
    documentlink = json['documentlink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    data['documentlink'] = this.documentlink;
    return data;
  }
}

class Documents {
  String? title;
  String? desciption;
  String? imagepath;
  String? createdAt;
  String? storename;

  Documents(
      {this.title,
        this.desciption,
        this.imagepath,
        this.createdAt,
        this.storename});

  Documents.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desciption = json['desciption'];
    imagepath = json['imagepath'];
    createdAt = json['created_at'];
    storename = json['storename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desciption'] = this.desciption;
    data['imagepath'] = this.imagepath;
    data['created_at'] = this.createdAt;
    data['storename'] = this.storename;
    return data;
  }
}
