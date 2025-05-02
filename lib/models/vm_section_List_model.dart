class VmSectionListModel {
  Success? success;

  VmSectionListModel({this.success});

  VmSectionListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic title;
  dynamic desciption;
  dynamic imagepath;
  dynamic uploadtype;
  dynamic createdAt;
  dynamic storename;
  List<Comments>? comments;
  dynamic totcomments;
  List<Reply>? reply;

  Documents(
      {this.id,
        this.title,
        this.desciption,
        this.imagepath,
        this.uploadtype,
        this.createdAt,
        this.storename,
        this.comments,
        this.totcomments,
        this.reply});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desciption = json['desciption'];
    imagepath = json['imagepath'];
    uploadtype = json['uploadtype'];
    createdAt = json['created_at'];
    storename = json['storename'];
    totcomments = json['totcomments'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    if (json['reply'] != null) {
      reply = <Reply>[];
      json['reply'].forEach((v) {
        reply!.add(new Reply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['totcomments'] = this.totcomments;
    data['desciption'] = this.desciption;
    data['imagepath'] = this.imagepath;
    data['uploadtype'] = this.uploadtype;
    data['created_at'] = this.createdAt;
    data['storename'] = this.storename;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.reply != null) {
      data['reply'] = this.reply!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  dynamic comments;
  dynamic createdAt;
  dynamic name;

  Comments({this.comments, this.createdAt, this.name});

  Comments.fromJson(Map<String, dynamic> json) {
    comments = json['comments'];
    createdAt = json['created_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments'] = this.comments;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    return data;
  }
}

class Reply {
  dynamic id;
  dynamic title;
  dynamic desciption;
  dynamic imagepath;
  dynamic uploadtype;
  dynamic parentId;
  dynamic isActive;
  dynamic createdBy;
  dynamic createdAt;
  dynamic updatedAt;

  Reply(
      {this.id,
        this.title,
        this.desciption,
        this.imagepath,
        this.uploadtype,
        this.parentId,
        this.isActive,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  Reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desciption = json['desciption'];
    imagepath = json['imagepath'];
    uploadtype = json['uploadtype'];
    parentId = json['parent_id'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desciption'] = this.desciption;
    data['imagepath'] = this.imagepath;
    data['uploadtype'] = this.uploadtype;
    data['parent_id'] = this.parentId;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
