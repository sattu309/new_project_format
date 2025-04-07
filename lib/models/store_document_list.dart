import 'admin_menu_category_list.dart';

class DocumentsListModel {
  Success? success;

  DocumentsListModel({this.success});

  DocumentsListModel.fromJson(Map<String, dynamic> json) {
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
  List<Breadcrumb>? breadcrumb;
  List<Documents>? documents;
  Doccatcurr? doccatcurr;
  List<Doccats>? doccats;
  String? documentlink;
  String? pdficon;
  String? imageicon;

  Success(
      {this.breadcrumb,
        this.documents,
        this.doccatcurr,
        this.doccats,
        this.documentlink,
        this.pdficon,
        this.imageicon});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumb'] != null) {
      breadcrumb = <Breadcrumb>[];
      json['breadcrumb'].forEach((v) {
        breadcrumb!.add(new Breadcrumb.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
    doccatcurr = json['doccatcurr'] != null
        ? new Doccatcurr.fromJson(json['doccatcurr'])
        : null;
    if (json['doccats'] != null) {
      doccats = <Doccats>[];
      json['doccats'].forEach((v) {
        doccats!.add(new Doccats.fromJson(v));
      });
    }
    documentlink = json['documentlink'];
    pdficon = json['pdficon'];
    imageicon = json['imageicon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumb != null) {
      data['breadcrumb'] = this.breadcrumb!.map((v) => v.toJson()).toList();
    }
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    if (this.doccatcurr != null) {
      data['doccatcurr'] = this.doccatcurr!.toJson();
    }
    if (this.doccats != null) {
      data['doccats'] = this.doccats!.map((v) => v.toJson()).toList();
    }
    data['documentlink'] = this.documentlink;
    data['pdficon'] = this.pdficon;
    data['imageicon'] = this.imageicon;
    return data;
  }
}

class Breadcrumb {
  String? slug;
  String? title;

  Breadcrumb({this.slug, this.title});

  Breadcrumb.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['title'] = this.title;
    return data;
  }
}

class Documents {
  dynamic id;
  dynamic title;
  dynamic categoryId;
  dynamic  documentname;
  dynamic featuredimage;
  dynamic filetype;
  dynamic description;
  dynamic dispOrder;
  dynamic isActive;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  Documents(
      {this.id,
        this.title,
        this.categoryId,
        this.documentname,
        this.featuredimage,
        this.filetype,
        this.description,
        this.dispOrder,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    documentname = json['documentname'];
    featuredimage = json['featuredimage'];
    filetype = json['filetype'];
    description = json['description'];
    dispOrder = json['disp_order'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['documentname'] = this.documentname;
    data['featuredimage'] = this.featuredimage;
    data['filetype'] = this.filetype;
    data['description'] = this.description;
    data['disp_order'] = this.dispOrder;
    data['is_active'] = this.isActive;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Doccatcurr {
  dynamic id;
  dynamic category;
  dynamic categoryslug;
  dynamic iconimage;

  Doccatcurr({this.id, this.category, this.categoryslug, this.iconimage});

  Doccatcurr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    categoryslug = json['categoryslug'];
    iconimage = json['iconimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['categoryslug'] = this.categoryslug;
    data['iconimage'] = this.iconimage;
    return data;
  }
}

