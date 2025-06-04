class CategoryListModel {
  Success? success;

  CategoryListModel({this.success});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
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
  List<NavItems>? navItems;
  String? bottomcardtitle;
  List<Bottomcards>? bottomcards;
  String? footercatalogues;
  String? enabletrengo;
  HeaderData? headerData;
  String? storeavailable;
  CommonImageData? commonImageData;
  List<DiscountText>? discountText;

  Success(
      {this.navItems,
        this.bottomcardtitle,
        this.bottomcards,
        this.footercatalogues,
        this.enabletrengo,
        this.headerData,
        this.storeavailable,
        this.commonImageData,
        this.discountText});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['navItems'] != null) {
      navItems = <NavItems>[];
      json['navItems'].forEach((v) {
        navItems!.add(new NavItems.fromJson(v));
      });
    }
    bottomcardtitle = json['bottomcardtitle'];
    if (json['bottomcards'] != null) {
      bottomcards = <Bottomcards>[];
      json['bottomcards'].forEach((v) {
        bottomcards!.add(new Bottomcards.fromJson(v));
      });
    }
    footercatalogues = json['footercatalogues'];
    enabletrengo = json['enabletrengo'];
    headerData = json['headerData'] != null
        ? new HeaderData.fromJson(json['headerData'])
        : null;
    storeavailable = json['storeavailable'];
    commonImageData = json['commonImageData'] != null
        ? new CommonImageData.fromJson(json['commonImageData'])
        : null;
    if (json['discountText'] != null) {
      discountText = <DiscountText>[];
      json['discountText'].forEach((v) {
        discountText!.add(new DiscountText.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.navItems != null) {
      data['navItems'] = this.navItems!.map((v) => v.toJson()).toList();
    }
    data['bottomcardtitle'] = this.bottomcardtitle;
    if (this.bottomcards != null) {
      data['bottomcards'] = this.bottomcards!.map((v) => v.toJson()).toList();
    }
    data['footercatalogues'] = this.footercatalogues;
    data['enabletrengo'] = this.enabletrengo;
    if (this.headerData != null) {
      data['headerData'] = this.headerData!.toJson();
    }
    data['storeavailable'] = this.storeavailable;
    if (this.commonImageData != null) {
      data['commonImageData'] = this.commonImageData!.toJson();
    }
    if (this.discountText != null) {
      data['discountText'] = this.discountText!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NavItems {
  String? label;
  String? slug;
  List<SubItems>? subItems;
  String? bgColor;
  String? color;

  NavItems({this.label, this.slug, this.subItems, this.bgColor, this.color});

  NavItems.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    slug = json['slug'];
    if (json['subItems'] != null) {
      subItems = <SubItems>[];
      json['subItems'].forEach((v) {
        subItems!.add(new SubItems.fromJson(v));
      });
    }
    bgColor = json['bg_color'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['slug'] = this.slug;
    if (this.subItems != null) {
      data['subItems'] = this.subItems!.map((v) => v.toJson()).toList();
    }
    data['bg_color'] = this.bgColor;
    data['color'] = this.color;
    return data;
  }
}

class SubItems {
  String? labelAll;
  String? slug;
  String? label;
  List<SubItems1>? subItems1;
  String? bgColor;
  String? color;

  SubItems(
      {this.labelAll,
        this.slug,
        this.label,
        this.subItems1,
        this.bgColor,
        this.color});

  SubItems.fromJson(Map<String, dynamic> json) {
    labelAll = json['label_all'];
    slug = json['slug'];
    label = json['label'];
    if (json['subItems1'] != null) {
      subItems1 = <SubItems1>[];
      json['subItems1'].forEach((v) {
        subItems1!.add(new SubItems1.fromJson(v));
      });
    }
    bgColor = json['bg_color'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label_all'] = this.labelAll;
    data['slug'] = this.slug;
    data['label'] = this.label;
    if (this.subItems1 != null) {
      data['subItems1'] = this.subItems1!.map((v) => v.toJson()).toList();
    }
    data['bg_color'] = this.bgColor;
    data['color'] = this.color;
    return data;
  }
}

class SubItems1 {
  String? labelAll;
  String? slug;
  String? label;
  List<SubItems2>? subItems2;

  SubItems1({this.labelAll, this.slug, this.label, this.subItems2});

  SubItems1.fromJson(Map<String, dynamic> json) {
    labelAll = json['label_all'];
    slug = json['slug'];
    label = json['label'];
    if (json['subItems2'] != null) {
      subItems2 = <SubItems2>[];
      json['subItems2'].forEach((v) {
        subItems2!.add(new SubItems2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label_all'] = this.labelAll;
    data['slug'] = this.slug;
    data['label'] = this.label;
    if (this.subItems2 != null) {
      data['subItems2'] = this.subItems2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubItems2 {
  String? labelAll;
  String? slug;
  String? label;

  SubItems2({this.labelAll, this.slug, this.label});

  SubItems2.fromJson(Map<String, dynamic> json) {
    labelAll = json['label_all'];
    slug = json['slug'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label_all'] = this.labelAll;
    data['slug'] = this.slug;
    data['label'] = this.label;
    return data;
  }
}

class Bottomcards {
  String? link;
  String? image;
  String? title;

  Bottomcards({this.link, this.image, this.title});

  Bottomcards.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}

class HeaderData {
  String? logo;
  String? bgColor;
  String? color;

  HeaderData({this.logo, this.bgColor, this.color});

  HeaderData.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    bgColor = json['bg_color'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['bg_color'] = this.bgColor;
    data['color'] = this.color;
    return data;
  }
}

class CommonImageData {
  String? cart;
  String? cartmobile;
  String? wishlist;
  String? wishlistmobile;
  String? subscribe;
  String? subscribemobile;
  String? img404;
  String? img404mobile;

  CommonImageData(
      {this.cart,
        this.cartmobile,
        this.wishlist,
        this.wishlistmobile,
        this.subscribe,
        this.subscribemobile,
        this.img404,
        this.img404mobile});

  CommonImageData.fromJson(Map<String, dynamic> json) {
    cart = json['cart'];
    cartmobile = json['cartmobile'];
    wishlist = json['wishlist'];
    wishlistmobile = json['wishlistmobile'];
    subscribe = json['subscribe'];
    subscribemobile = json['subscribemobile'];
    img404 = json['img404'];
    img404mobile = json['img404mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart'] = this.cart;
    data['cartmobile'] = this.cartmobile;
    data['wishlist'] = this.wishlist;
    data['wishlistmobile'] = this.wishlistmobile;
    data['subscribe'] = this.subscribe;
    data['subscribemobile'] = this.subscribemobile;
    data['img404'] = this.img404;
    data['img404mobile'] = this.img404mobile;
    return data;
  }
}

class DiscountText {
  String? text;
  String? link;

  DiscountText({this.text, this.link});

  DiscountText.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['link'] = this.link;
    return data;
  }
}
