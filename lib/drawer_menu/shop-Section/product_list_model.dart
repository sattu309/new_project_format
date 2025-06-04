class ProductListModel {
  Success? success;

  ProductListModel({this.success});

  ProductListModel.fromJson(Map<String, dynamic> json) {
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
  List<Products>? products;
  BannerImage? bannerImage;
  List<Breadcrumb>? breadcrumb;

  Success({this.products, this.bannerImage, this.breadcrumb});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    bannerImage = json['bannerImage'] != null
        ? new BannerImage.fromJson(json['bannerImage'])
        : null;
    if (json['breadcrumb'] != null) {
      breadcrumb = <Breadcrumb>[];
      json['breadcrumb'].forEach((v) {
        breadcrumb!.add(new Breadcrumb.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.bannerImage != null) {
      data['bannerImage'] = this.bannerImage!.toJson();
    }
    if (this.breadcrumb != null) {
      data['breadcrumb'] = this.breadcrumb!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? image;
  String? badgetext;
  String? badgetextbg;
  String? badgetextcolor;
  String? badge;
  String? slug;
  String? subtext;
  String? productname;
  int? productId;
  String? actPrice;
  String? dispPrice;
  List<int>? dispPriceArr;
  int? inventory;
  String? stockdetail;

  Products(
      {this.image,
        this.badgetext,
        this.badgetextbg,
        this.badgetextcolor,
        this.badge,
        this.slug,
        this.subtext,
        this.productname,
        this.productId,
        this.actPrice,
        this.dispPrice,
        this.dispPriceArr,
        this.inventory,
        this.stockdetail});

  Products.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    badgetext = json['badgetext'];
    badgetextbg = json['badgetextbg'];
    badgetextcolor = json['badgetextcolor'];
    badge = json['badge'];
    slug = json['slug'];
    subtext = json['subtext'];
    productname = json['productname'];
    productId = json['product_id'];
    actPrice = json['actPrice'];
    dispPrice = json['dispPrice'];
    dispPriceArr = json['dispPriceArr'].cast<int>();
    inventory = json['inventory'];
    stockdetail = json['stockdetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['badgetext'] = this.badgetext;
    data['badgetextbg'] = this.badgetextbg;
    data['badgetextcolor'] = this.badgetextcolor;
    data['badge'] = this.badge;
    data['slug'] = this.slug;
    data['subtext'] = this.subtext;
    data['productname'] = this.productname;
    data['product_id'] = this.productId;
    data['actPrice'] = this.actPrice;
    data['dispPrice'] = this.dispPrice;
    data['dispPriceArr'] = this.dispPriceArr;
    data['inventory'] = this.inventory;
    data['stockdetail'] = this.stockdetail;
    return data;
  }
}

class BannerImage {
  String? bannerimg;
  String? bannerimgmob;
  String? badgeimage;
  String? cattitle;
  String? color;
  String? font;

  BannerImage(
      {this.bannerimg,
        this.bannerimgmob,
        this.badgeimage,
        this.cattitle,
        this.color,
        this.font});

  BannerImage.fromJson(Map<String, dynamic> json) {
    bannerimg = json['bannerimg'];
    bannerimgmob = json['bannerimgmob'];
    badgeimage = json['badgeimage'];
    cattitle = json['cattitle'];
    color = json['color'];
    font = json['font'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerimg'] = this.bannerimg;
    data['bannerimgmob'] = this.bannerimgmob;
    data['badgeimage'] = this.badgeimage;
    data['cattitle'] = this.cattitle;
    data['color'] = this.color;
    data['font'] = this.font;
    return data;
  }
}

class Breadcrumb {
  String? title;
  String? slug;

  Breadcrumb({this.title, this.slug});

  Breadcrumb.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    return data;
  }
}
