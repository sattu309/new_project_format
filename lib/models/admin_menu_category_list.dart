class GetAdminMenuCategoryList {
  Success? success;

  GetAdminMenuCategoryList({this.success});

  GetAdminMenuCategoryList.fromJson(Map<String, dynamic> json) {
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
  List<Doccats>? doccats;
  String? documentlink;

  Success({this.breadcrumb, this.doccats, this.documentlink});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumb'] != null) {
      breadcrumb = <Breadcrumb>[];
      json['breadcrumb'].forEach((v) {
        breadcrumb!.add(new Breadcrumb.fromJson(v));
      });
    }
    if (json['doccats'] != null) {
      doccats = <Doccats>[];
      json['doccats'].forEach((v) {
        doccats!.add(new Doccats.fromJson(v));
      });
    }
    documentlink = json['documentlink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumb != null) {
      data['breadcrumb'] = this.breadcrumb!.map((v) => v.toJson()).toList();
    }
    if (this.doccats != null) {
      data['doccats'] = this.doccats!.map((v) => v.toJson()).toList();
    }
    data['documentlink'] = this.documentlink;
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

class Doccats {
  dynamic id;
  dynamic category;
  dynamic categoryslug;
  dynamic iconimage;

  Doccats({this.id, this.category, this.categoryslug, this.iconimage});

  Doccats.fromJson(Map<String, dynamic> json) {
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
