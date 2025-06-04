class ProductDetailModel {
  Success? success;

  ProductDetailModel({this.success});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    success =
    json['success'] != null ? Success.fromJson(json['success']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success!.toJson();
    }
    return data;
  }
}

class Success {
  dynamic showcollect;
  ProductData? productData;
  Stores? stores;
  dynamic notforsale;
  dynamic title;
  dynamic variant;
  dynamic description;
  List<MetaDetails>? metaDetails;

  Success(
      {this.showcollect,
        this.productData,
        this.stores,
        this.notforsale,
        this.title,
        this.variant,
        this.description,
        this.metaDetails});

  Success.fromJson(Map<String, dynamic> json) {
    showcollect = json['showcollect'];
    productData = json['productData'] != null
        ? ProductData.fromJson(json['productData'])
        : null;
    stores =
    json['stores'] != null && json['stores'] is Map<String, dynamic> ? Stores.fromJson(json['stores']) : null;

    notforsale = json['notforsale'];
    title = json['title'];
    variant = json['variant'];
    description = json['description'];
    if (json['metaDetails'] != null) {
      metaDetails = <MetaDetails>[];
      json['metaDetails'].forEach((v) {
        metaDetails!.add(MetaDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['showcollect'] = this.showcollect;
    if (this.productData != null) {
      data['productData'] = this.productData!.toJson();
    }
    if (this.stores != null) {
      data['stores'] = this.stores!.toJson();
    }
    data['notforsale'] = this.notforsale;
    data['title'] = this.title;
    data['variant'] = this.variant;
    data['description'] = this.description;
    if (this.metaDetails != null) {
      data['metaDetails'] = this.metaDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  List<ProductImages>? productImages;
  List<Breadcrumb>? breadcrumb;
  dynamic badgetext;
  dynamic badgetextbg;
  dynamic badgetextcolor;
  dynamic badge;
  dynamic productname;
  dynamic subTxt;
  dynamic subTxtColor;
  dynamic description;
  dynamic subtext;
  dynamic productId;
  dynamic productcode;
  List<ProductVariation>? productVariation;
  List<Null>? singleproduct;
  List<VisitedProducts>? visitedProducts;
  // List<RecommendProducts>? recommendProducts;
  dynamic sizeguidetitle;
  dynamic sizeguide;
  ShareButtons? shareButtons;
  List<AddInfoList>? addInfoList;
  dynamic shortdesc;
  dynamic actPrice;
  dynamic dispPrice;
  List<int>? dispPriceArr;
  dynamic slug;
  dynamic inventory;
  dynamic stockdetail;
  dynamic tfgimage;
  dynamic tfgtext;
  dynamic categoryname;

  ProductData(
      {this.productImages,
        this.breadcrumb,
        this.badgetext,
        this.badgetextbg,
        this.badgetextcolor,
        this.badge,
        this.productname,
        this.subTxt,
        this.subTxtColor,
        this.description,
        this.subtext,
        this.productId,
        this.productcode,
        this.productVariation,
        this.singleproduct,
        this.visitedProducts,
        // this.recommendProducts,
        this.sizeguidetitle,
        this.sizeguide,
        this.shareButtons,
        this.addInfoList,
        this.shortdesc,
        this.actPrice,
        this.dispPrice,
        this.dispPriceArr,
        this.slug,
        this.inventory,
        this.stockdetail,
        this.tfgimage,
        this.tfgtext,
        this.categoryname});

  ProductData.fromJson(Map<String, dynamic> json) {
    if (json['productImages'] != null) {
      productImages = <ProductImages>[];
      json['productImages'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
    if (json['breadcrumb'] != null) {
      breadcrumb = <Breadcrumb>[];
      json['breadcrumb'].forEach((v) {
        breadcrumb!.add(Breadcrumb.fromJson(v));
      });
    }
    badgetext = json['badgetext'];
    badgetextbg = json['badgetextbg'];
    badgetextcolor = json['badgetextcolor'];
    badge = json['badge'];
    productname = json['productname'];
    subTxt = json['Sub_txt'];
    subTxtColor = json['Sub_txtColor'];
    description = json['description'];
    subtext = json['subtext'];
    productId = json['product_id'];
    productcode = json['productcode'];
    if (json['productVariation'] != null) {
      productVariation = <ProductVariation>[];
      json['productVariation'].forEach((v) {
        productVariation!.add(ProductVariation.fromJson(v));
      });
    }
    if (json['singleproduct'] != null) {
      singleproduct = <Null>[];
      // json['singleproduct'].forEach((v) {
      //   singleproduct!.add(new Null.fromJson(v));
      // });
    }
    if (json['visitedProducts'] != null) {
      visitedProducts = <VisitedProducts>[];
      json['visitedProducts'].forEach((v) {
        visitedProducts!.add(VisitedProducts.fromJson(v));
      });
    }
    // if (json['recommendProducts'] != null) {
    //   recommendProducts = <RecommendProducts>[];
    //   json['recommendProducts'].forEach((v) {
    //     recommendProducts!.add(new RecommendProducts.fromJson(v));
    //   });
    // }
    sizeguidetitle = json['sizeguidetitle'];
    sizeguide = json['sizeguide'];
    shareButtons = json['shareButtons'] != null
        ? ShareButtons.fromJson(json['shareButtons'])
        : null;
    if (json['addInfoList'] != null) {
      addInfoList = <AddInfoList>[];
      json['addInfoList'].forEach((v) {
        addInfoList!.add(AddInfoList.fromJson(v));
      });
    }
    shortdesc = json['shortdesc'];
    actPrice = json['actPrice'];
    dispPrice = json['dispPrice'];
    dispPriceArr = json['dispPriceArr'].cast<int>();
    slug = json['slug'];
    inventory = json['inventory'];
    stockdetail = json['stockdetail'];
    tfgimage = json['tfgimage'];
    tfgtext = json['tfgtext'];
    categoryname = json['categoryname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.productImages != null) {
      data['productImages'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    if (this.breadcrumb != null) {
      data['breadcrumb'] = this.breadcrumb!.map((v) => v.toJson()).toList();
    }
    data['badgetext'] = this.badgetext;
    data['badgetextbg'] = this.badgetextbg;
    data['badgetextcolor'] = this.badgetextcolor;
    data['badge'] = this.badge;
    data['productname'] = this.productname;
    data['Sub_txt'] = this.subTxt;
    data['Sub_txtColor'] = this.subTxtColor;
    data['description'] = this.description;
    data['subtext'] = this.subtext;
    data['product_id'] = this.productId;
    data['productcode'] = this.productcode;
    if (this.productVariation != null) {
      data['productVariation'] =
          this.productVariation!.map((v) => v.toJson()).toList();
    }
    // if (this.singleproduct != null) {
    //   data['singleproduct'] =
    //       this.singleproduct!.map((v) => v.toJson()).toList();
    // }
    if (this.visitedProducts != null) {
      data['visitedProducts'] =
          this.visitedProducts!.map((v) => v.toJson()).toList();
    }
    // if (this.recommendProducts != null) {
    //   data['recommendProducts'] =
    //       this.recommendProducts!.map((v) => v.toJson()).toList();
    // }
    data['sizeguidetitle'] = this.sizeguidetitle;
    data['sizeguide'] = this.sizeguide;
    if (this.shareButtons != null) {
      data['shareButtons'] = this.shareButtons!.toJson();
    }
    if (this.addInfoList != null) {
      data['addInfoList'] = this.addInfoList!.map((v) => v.toJson()).toList();
    }
    data['shortdesc'] = this.shortdesc;
    data['actPrice'] = this.actPrice;
    data['dispPrice'] = this.dispPrice;
    data['dispPriceArr'] = this.dispPriceArr;
    data['slug'] = this.slug;
    data['inventory'] = this.inventory;
    data['stockdetail'] = this.stockdetail;
    data['tfgimage'] = this.tfgimage;
    data['tfgtext'] = this.tfgtext;
    data['categoryname'] = this.categoryname;
    return data;
  }
}

class ProductImages {
  String? path;
  String? imagename;

  ProductImages({this.path, this.imagename});

  ProductImages.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    imagename = json['imagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['path'] = this.path;
    data['imagename'] = this.imagename;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['slug'] = this.slug;
    data['title'] = this.title;
    return data;
  }
}

class ProductVariation {
  dynamic stockdetail;
  dynamic title;
  dynamic productId;
  dynamic productvariantId;
  dynamic inventory;
  dynamic description;
  dynamic varsku;
  dynamic attributetermId;
  Attributeterm? attributeterm;
  dynamic size;
  dynamic sizeline1;
  dynamic image;
  dynamic price;
  dynamic saleprice;

  ProductVariation(
      {this.stockdetail,
        this.title,
        this.productId,
        this.productvariantId,
        this.inventory,
        this.description,
        this.varsku,
        this.attributetermId,
        this.attributeterm,
        this.size,
        this.sizeline1,
        this.image,
        this.price,
        this.saleprice});

  ProductVariation.fromJson(Map<String, dynamic> json) {
    stockdetail = json['stockdetail'];
    title = json['title'];
    productId = json['product_id'];
    productvariantId = json['productvariant_id'];
    inventory = json['inventory'];
    description = json['description'];
    varsku = json['varsku'];
    attributetermId = json['attributeterm_id'];
    attributeterm = json['attributeterm'] != null
        ? Attributeterm.fromJson(json['attributeterm'])
        : null;
    size = json['size'];
    sizeline1 = json['sizeline1'];
    image = json['image'];
    price = json['price'];
    saleprice = json['saleprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['stockdetail'] = this.stockdetail;
    data['title'] = this.title;
    data['product_id'] = this.productId;
    data['productvariant_id'] = this.productvariantId;
    data['inventory'] = this.inventory;
    data['description'] = this.description;
    data['varsku'] = this.varsku;
    data['attributeterm_id'] = this.attributetermId;
    if (this.attributeterm != null) {
      data['attributeterm'] = this.attributeterm!.toJson();
    }
    data['size'] = this.size;
    data['sizeline1'] = this.sizeline1;
    data['image'] = this.image;
    data['price'] = this.price;
    data['saleprice'] = this.saleprice;
    return data;
  }
}

class Attributeterm {
  dynamic id;
  dynamic termname;
  dynamic attributeId;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  Attributeterm(
      {this.id,
        this.termname,
        this.attributeId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Attributeterm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    termname = json['termname'];
    attributeId = json['attribute_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['termname'] = this.termname;
    data['attribute_id'] = this.attributeId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class VisitedProducts {
  String? image;
  String? badgetext;
  String? badgetextbg;
  String? badgetextcolor;
  String? badge;
  String? slug;
  String? subtext;
  String? productname;
  String? actPrice;
  String? dispPrice;
  List<int>? dispPriceArr;
  int? inventory;
  String? stockdetail;

  VisitedProducts(
      {this.image,
        this.badgetext,
        this.badgetextbg,
        this.badgetextcolor,
        this.badge,
        this.slug,
        this.subtext,
        this.productname,
        this.actPrice,
        this.dispPrice,
        this.dispPriceArr,
        this.inventory,
        this.stockdetail});

  VisitedProducts.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    badgetext = json['badgetext'];
    badgetextbg = json['badgetextbg'];
    badgetextcolor = json['badgetextcolor'];
    badge = json['badge'];
    slug = json['slug'];
    subtext = json['subtext'];
    productname = json['productname'];
    actPrice = json['actPrice'];
    dispPrice = json['dispPrice'];
    dispPriceArr = json['dispPriceArr'].cast<int>();
    inventory = json['inventory'];
    stockdetail = json['stockdetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = this.image;
    data['badgetext'] = this.badgetext;
    data['badgetextbg'] = this.badgetextbg;
    data['badgetextcolor'] = this.badgetextcolor;
    data['badge'] = this.badge;
    data['slug'] = this.slug;
    data['subtext'] = this.subtext;
    data['productname'] = this.productname;
    data['actPrice'] = this.actPrice;
    data['dispPrice'] = this.dispPrice;
    data['dispPriceArr'] = this.dispPriceArr;
    data['inventory'] = this.inventory;
    data['stockdetail'] = this.stockdetail;
    return data;
  }
}

class ShareButtons {
  String? facebook;
  String? telegram;
  String? whatsapp;

  ShareButtons({this.facebook, this.telegram, this.whatsapp});

  ShareButtons.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    telegram = json['telegram'];
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['facebook'] = this.facebook;
    data['telegram'] = this.telegram;
    data['whatsapp'] = this.whatsapp;
    return data;
  }
}

class AddInfoList {
  String? title;
  String? value;

  AddInfoList({this.title, this.value});

  AddInfoList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    return data;
  }
}

class Stores {
  List<EasternCape>? easternCape;
  List<FreeState>? freeState;
  List<Gauteng>? gauteng;
  List<KwaZuluNatal>? kwaZuluNatal;
  List<Limpopo>? limpopo;
  List<Mpumalanga>? mpumalanga;
  List<NorthWest>? northWest;
  List<NorthernCape>? northernCape;
  List<WesternCape>? westernCape;

  Stores(
      {this.easternCape,
        this.freeState,
        this.gauteng,
        this.kwaZuluNatal,
        this.limpopo,
        this.mpumalanga,
        this.northWest,
        this.northernCape,
        this.westernCape});

  Stores.fromJson(Map<String, dynamic> json) {
    if (json['Eastern Cape'] != null) {
      easternCape = <EasternCape>[];
      json['Eastern Cape'].forEach((v) {
        easternCape!.add(EasternCape.fromJson(v));
      });
    }
    if (json['Free State'] != null) {
      freeState = <FreeState>[];
      json['Free State'].forEach((v) {
        freeState!.add(FreeState.fromJson(v));
      });
    }
    if (json['Gauteng'] != null) {
      gauteng = <Gauteng>[];
      json['Gauteng'].forEach((v) {
        gauteng!.add(Gauteng.fromJson(v));
      });
    }
    if (json['KwaZulu-Natal'] != null) {
      kwaZuluNatal = <KwaZuluNatal>[];
      json['KwaZulu-Natal'].forEach((v) {
        kwaZuluNatal!.add(KwaZuluNatal.fromJson(v));
      });
    }
    if (json['Limpopo'] != null) {
      limpopo = <Limpopo>[];
      json['Limpopo'].forEach((v) {
        limpopo!.add(Limpopo.fromJson(v));
      });
    }
    if (json['Mpumalanga'] != null) {
      mpumalanga = <Mpumalanga>[];
      json['Mpumalanga'].forEach((v) {
        mpumalanga!.add(Mpumalanga.fromJson(v));
      });
    }
    if (json['North West'] != null) {
      northWest = <NorthWest>[];
      json['North West'].forEach((v) {
        northWest!.add(NorthWest.fromJson(v));
      });
    }
    if (json['Northern Cape'] != null) {
      northernCape = <NorthernCape>[];
      json['Northern Cape'].forEach((v) {
        northernCape!.add(NorthernCape.fromJson(v));
      });
    }
    if (json['Western Cape'] != null) {
      westernCape = <WesternCape>[];
      json['Western Cape'].forEach((v) {
        westernCape!.add(WesternCape.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.easternCape != null) {
      data['Eastern Cape'] = this.easternCape!.map((v) => v.toJson()).toList();
    }
    if (this.freeState != null) {
      data['Free State'] = this.freeState!.map((v) => v.toJson()).toList();
    }
    if (this.gauteng != null) {
      data['Gauteng'] = this.gauteng!.map((v) => v.toJson()).toList();
    }
    if (this.kwaZuluNatal != null) {
      data['KwaZulu-Natal'] =
          this.kwaZuluNatal!.map((v) => v.toJson()).toList();
    }
    if (this.limpopo != null) {
      data['Limpopo'] = this.limpopo!.map((v) => v.toJson()).toList();
    }
    if (this.mpumalanga != null) {
      data['Mpumalanga'] = this.mpumalanga!.map((v) => v.toJson()).toList();
    }
    if (this.northWest != null) {
      data['North West'] = this.northWest!.map((v) => v.toJson()).toList();
    }
    if (this.northernCape != null) {
      data['Northern Cape'] =
          this.northernCape!.map((v) => v.toJson()).toList();
    }
    if (this.westernCape != null) {
      data['Western Cape'] = this.westernCape!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EasternCape {
  int? id;
  String? storename;
  String? phoneNumber;
  String? storeSlug;
  String? address;
  String? address1;
  String? address2;
  String? city;
  String? province;
  String? postalCode;

  EasternCape(
      {this.id,
        this.storename,
        this.phoneNumber,
        this.storeSlug,
        this.address,
        this.address1,
        this.address2,
        this.city,
        this.province,
        this.postalCode});

  EasternCape.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storename = json['storename'];
    phoneNumber = json['phone_number'];
    storeSlug = json['store_slug'];
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['storename'] = this.storename;
    data['phone_number'] = this.phoneNumber;
    data['store_slug'] = this.storeSlug;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['province'] = this.province;
    data['postal_code'] = this.postalCode;
    return data;
  }
}
class FreeState {
  int? id;
  String? storename;
  String? phoneNumber;
  String? storeSlug;
  String? address;
  String? address1;
  String? address2;
  String? city;
  String? province;
  String? postalCode;

  FreeState(
      {this.id,
        this.storename,
        this.phoneNumber,
        this.storeSlug,
        this.address,
        this.address1,
        this.address2,
        this.city,
        this.province,
        this.postalCode});

  FreeState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storename = json['storename'];
    phoneNumber = json['phone_number'];
    storeSlug = json['store_slug'];
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['storename'] = this.storename;
    data['phone_number'] = this.phoneNumber;
    data['store_slug'] = this.storeSlug;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['province'] = this.province;
    data['postal_code'] = this.postalCode;
    return data;
  }
}
class Gauteng {
  int? id;
  String? storename;
  String? phoneNumber;
  String? storeSlug;
  String? address;
  String? address1;
  String? address2;
  String? city;
  String? province;
  String? postalCode;

  Gauteng(
      {this.id,
        this.storename,
        this.phoneNumber,
        this.storeSlug,
        this.address,
        this.address1,
        this.address2,
        this.city,
        this.province,
        this.postalCode});

  Gauteng.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storename = json['storename'];
    phoneNumber = json['phone_number'];
    storeSlug = json['store_slug'];
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['storename'] = this.storename;
    data['phone_number'] = this.phoneNumber;
    data['store_slug'] = this.storeSlug;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['province'] = this.province;
    data['postal_code'] = this.postalCode;
    return data;
  }
}
class KwaZuluNatal {
  int? id;
  String? storename;
  String? phoneNumber;
  String? storeSlug;
  String? address;
  String? address1;
  String? address2;
  String? city;
  String? province;
  String? postalCode;

  KwaZuluNatal(
      {this.id,
        this.storename,
        this.phoneNumber,
        this.storeSlug,
        this.address,
        this.address1,
        this.address2,
        this.city,
        this.province,
        this.postalCode});

  KwaZuluNatal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storename = json['storename'];
    phoneNumber = json['phone_number'];
    storeSlug = json['store_slug'];
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['storename'] = this.storename;
    data['phone_number'] = this.phoneNumber;
    data['store_slug'] = this.storeSlug;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['province'] = this.province;
    data['postal_code'] = this.postalCode;
    return data;
  }
}
class Limpopo {
  int? id;
  String? storename;
  String? phoneNumber;
  String? storeSlug;
  String? address;
  String? address1;
  String? address2;
  String? city;
  String? province;
  String? postalCode;

  Limpopo(
      {this.id,
        this.storename,
        this.phoneNumber,
        this.storeSlug,
        this.address,
        this.address1,
        this.address2,
        this.city,
        this.province,
        this.postalCode});

  Limpopo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storename = json['storename'];
    phoneNumber = json['phone_number'];
    storeSlug = json['store_slug'];
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['storename'] = this.storename;
    data['phone_number'] = this.phoneNumber;
    data['store_slug'] = this.storeSlug;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['province'] = this.province;
    data['postal_code'] = this.postalCode;
    return data;
  }
}
class Mpumalanga {
  int? id;
  String? storename;
  String? phoneNumber;
  String? storeSlug;
  String? address;
  String? address1;
  String? address2;
  String? city;
  String? province;
  String? postalCode;

  Mpumalanga(
      {this.id,
        this.storename,
        this.phoneNumber,
        this.storeSlug,
        this.address,
        this.address1,
        this.address2,
        this.city,
        this.province,
        this.postalCode});

  Mpumalanga.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storename = json['storename'];
    phoneNumber = json['phone_number'];
    storeSlug = json['store_slug'];
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['storename'] = this.storename;
    data['phone_number'] = this.phoneNumber;
    data['store_slug'] = this.storeSlug;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['province'] = this.province;
    data['postal_code'] = this.postalCode;
    return data;
  }
}
class NorthWest {
  int? id;
  String? storename;
  String? phoneNumber;
  String? storeSlug;
  String? address;
  String? address1;
  String? address2;
  String? city;
  String? province;
  String? postalCode;

  NorthWest(
      {this.id,
        this.storename,
        this.phoneNumber,
        this.storeSlug,
        this.address,
        this.address1,
        this.address2,
        this.city,
        this.province,
        this.postalCode});

  NorthWest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storename = json['storename'];
    phoneNumber = json['phone_number'];
    storeSlug = json['store_slug'];
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['storename'] = this.storename;
    data['phone_number'] = this.phoneNumber;
    data['store_slug'] = this.storeSlug;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['province'] = this.province;
    data['postal_code'] = this.postalCode;
    return data;
  }
}
class NorthernCape {
  int? id;
  String? storename;
  String? phoneNumber;
  String? storeSlug;
  String? address;
  String? address1;
  String? address2;
  String? city;
  String? province;
  String? postalCode;

  NorthernCape(
      {this.id,
        this.storename,
        this.phoneNumber,
        this.storeSlug,
        this.address,
        this.address1,
        this.address2,
        this.city,
        this.province,
        this.postalCode});

  NorthernCape.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storename = json['storename'];
    phoneNumber = json['phone_number'];
    storeSlug = json['store_slug'];
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['storename'] = this.storename;
    data['phone_number'] = this.phoneNumber;
    data['store_slug'] = this.storeSlug;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['province'] = this.province;
    data['postal_code'] = this.postalCode;
    return data;
  }
}
class WesternCape {
  int? id;
  String? storename;
  String? phoneNumber;
  String? storeSlug;
  String? address;
  String? address1;
  String? address2;
  String? city;
  String? province;
  String? postalCode;

  WesternCape(
      {this.id,
        this.storename,
        this.phoneNumber,
        this.storeSlug,
        this.address,
        this.address1,
        this.address2,
        this.city,
        this.province,
        this.postalCode});

  WesternCape.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storename = json['storename'];
    phoneNumber = json['phone_number'];
    storeSlug = json['store_slug'];
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['storename'] = this.storename;
    data['phone_number'] = this.phoneNumber;
    data['store_slug'] = this.storeSlug;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['province'] = this.province;
    data['postal_code'] = this.postalCode;
    return data;
  }
}

class MetaDetails {
  dynamic property;
  dynamic content;

  MetaDetails({this.property, this.content});

  MetaDetails.fromJson(Map<String, dynamic> json) {
    property = json['property'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['property'] = this.property;
    data['content'] = this.content;
    return data;
  }
}
