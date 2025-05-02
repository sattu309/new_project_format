class GetCartModel {
  Success? success;

  GetCartModel({this.success});

  GetCartModel.fromJson(Map<String, dynamic> json) {
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
  dynamic imagepath;
  dynamic qtyTot;
  List<Null>? buytogether;
  dynamic discountAmount;
  List<Null>? discData;
  dynamic discountString;

  Success(
      {this.products,
        this.imagepath,
        this.qtyTot,
        this.buytogether,
        this.discountAmount,
        this.discData,
        this.discountString});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    imagepath = json['imagepath'];
    qtyTot = json['qtyTot'];
    // if (json['buytogether'] != null) {
    //   buytogether = <Null>[];
    //   json['buytogether'].forEach((v) {
    //     buytogether!.add(new Null.fromJson(v));
    //   });
    // }
    discountAmount = json['discountAmount'];
    // if (json['discData'] != null) {
    //   discData = <Null>[];
    //   json['discData'].forEach((v) {
    //     discData!.add(new Null.fromJson(v));
    //   });
    // }
    discountString = json['discount_string'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['imagepath'] = this.imagepath;
    data['qtyTot'] = this.qtyTot;
    // if (this.buytogether != null) {
    //   data['buytogether'] = this.buytogether!.map((v) => v.toJson()).toList();
    // }
    data['discountAmount'] = this.discountAmount;
    // if (this.discData != null) {
    //   data['discData'] = this.discData!.map((v) => v.toJson()).toList();
    // }
    data['discount_string'] = this.discountString;
    return data;
  }
}

class Products {
  dynamic id;
  dynamic sessionid;
  dynamic usersId;
  dynamic productId;
  dynamic productvariantId;
  dynamic qty;
  dynamic price;
  dynamic amount;
  dynamic productname;
  dynamic varname;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic slug;
  dynamic image;
  dynamic saleprice;
  dynamic isPromo;
  dynamic cartmsg;
  dynamic discount;
  dynamic isStorestock;

  Products(
      {this.id,
        this.sessionid,
        this.usersId,
        this.productId,
        this.productvariantId,
        this.qty,
        this.price,
        this.amount,
        this.productname,
        this.varname,
        this.createdAt,
        this.updatedAt,
        this.slug,
        this.image,
        this.saleprice,
        this.isPromo,
        this.cartmsg,
        this.discount,
        this.isStorestock});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionid = json['sessionid'];
    usersId = json['users_id'];
    productId = json['product_id'];
    productvariantId = json['productvariant_id'];
    qty = json['qty'];
    price = json['price'];
    amount = json['amount'];
    productname = json['productname'];
    varname = json['varname'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
    image = json['image'];
    saleprice = json['saleprice'];
    isPromo = json['is_promo'];
    cartmsg = json['cartmsg'];
    discount = json['discount'];
    isStorestock = json['is_storestock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sessionid'] = this.sessionid;
    data['users_id'] = this.usersId;
    data['product_id'] = this.productId;
    data['productvariant_id'] = this.productvariantId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['productname'] = this.productname;
    data['varname'] = this.varname;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['saleprice'] = this.saleprice;
    data['is_promo'] = this.isPromo;
    data['cartmsg'] = this.cartmsg;
    data['discount'] = this.discount;
    data['is_storestock'] = this.isStorestock;
    return data;
  }
}
