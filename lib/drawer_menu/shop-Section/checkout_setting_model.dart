class CheckoutSettingModel {
  Success? success;

  CheckoutSettingModel({this.success});

  CheckoutSettingModel.fromJson(Map<String, dynamic> json) {
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
  dynamic usersId;
  dynamic sessionId;
  dynamic showcollect;
  List<Salespersons>? salespersons;
  List<Null>? stores;
  Shipaddress? shipaddress;
  Billaddress? billaddress;
  dynamic shippingamount;
  dynamic shiptocustshippingamount;
  List<PaymentModes>? paymentModes;
  List<Provinces>? provinces;
  dynamic storeinstock;
  dynamic noshipprd;
  List<CheckoutArr>? checkoutArr;

  Success(
      {this.usersId,
        this.sessionId,
        this.showcollect,
        this.salespersons,
        this.stores,
        this.shipaddress,
        this.billaddress,
        this.shippingamount,
        this.shiptocustshippingamount,
        this.paymentModes,
        this.provinces,
        this.storeinstock,
        this.noshipprd,
        this.checkoutArr});

  Success.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    sessionId = json['session_id'];
    showcollect = json['showcollect'];
    if (json['salespersons'] != null) {
      salespersons = <Salespersons>[];
      json['salespersons'].forEach((v) {
        salespersons!.add(new Salespersons.fromJson(v));
      });
    }
    // if (json['stores'] != null) {
    //   stores = <Null>[];
    //   json['stores'].forEach((v) {
    //     stores!.add(new Null.fromJson(v));
    //   });
    // }
    shipaddress = json['shipaddress'] != null
        ? new Shipaddress.fromJson(json['shipaddress'])
        : null;
    billaddress = json['billaddress'] != null
        ? new Billaddress.fromJson(json['billaddress'])
        : null;
    shippingamount = json['shippingamount'];
    shiptocustshippingamount = json['shiptocustshippingamount'];
    if (json['paymentModes'] != null) {
      paymentModes = <PaymentModes>[];
      json['paymentModes'].forEach((v) {
        paymentModes!.add(new PaymentModes.fromJson(v));
      });
    }
    if (json['provinces'] != null) {
      provinces = <Provinces>[];
      json['provinces'].forEach((v) {
        provinces!.add(new Provinces.fromJson(v));
      });
    }
    storeinstock = json['storeinstock'];
    noshipprd = json['noshipprd'];
    if (json['checkoutArr'] != null) {
      checkoutArr = <CheckoutArr>[];
      json['checkoutArr'].forEach((v) {
        checkoutArr!.add(new CheckoutArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id'] = this.usersId;
    data['session_id'] = this.sessionId;
    data['showcollect'] = this.showcollect;
    if (this.salespersons != null) {
      data['salespersons'] = this.salespersons!.map((v) => v.toJson()).toList();
    }
    /*if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }*/
    if (this.shipaddress != null) {
      data['shipaddress'] = this.shipaddress!.toJson();
    }
    if (this.billaddress != null) {
      data['billaddress'] = this.billaddress!.toJson();
    }
    data['shippingamount'] = this.shippingamount;
    data['shiptocustshippingamount'] = this.shiptocustshippingamount;
    if (this.paymentModes != null) {
      data['paymentModes'] = this.paymentModes!.map((v) => v.toJson()).toList();
    }
    if (this.provinces != null) {
      data['provinces'] = this.provinces!.map((v) => v.toJson()).toList();
    }
    data['storeinstock'] = this.storeinstock;
    data['noshipprd'] = this.noshipprd;
    if (this.checkoutArr != null) {
      data['checkoutArr'] = this.checkoutArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Salespersons {
  dynamic iD;
  dynamic firstName;
  dynamic lastName;
  dynamic salesPerson;
  dynamic storeNo;
  dynamic storeName;
  dynamic name;

  Salespersons(
      {this.iD,
        this.firstName,
        this.lastName,
        this.salesPerson,
        this.storeNo,
        this.storeName,
        this.name});

  Salespersons.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    firstName = json['First_Name'];
    lastName = json['Last_Name'];
    salesPerson = json['Sales_Person'];
    storeNo = json['Store_No'];
    storeName = json['Store_Name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['First_Name'] = this.firstName;
    data['Last_Name'] = this.lastName;
    data['Sales_Person'] = this.salesPerson;
    data['Store_No'] = this.storeNo;
    data['Store_Name'] = this.storeName;
    data['name'] = this.name;
    return data;
  }
}

class Shipaddress {
  dynamic id;
  dynamic usersId;
  dynamic addresstype;
  dynamic address1;
  dynamic address2;
  dynamic suburb;
  dynamic city;
  dynamic postcode;
  dynamic country;
  dynamic phone;
  dynamic phonecode;
  dynamic email;
  dynamic ordersId;
  dynamic isDefault;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic fname;
  dynamic lname;
  dynamic province;
  dynamic companyname;
  dynamic vat;

  Shipaddress(
      {this.id,
        this.usersId,
        this.addresstype,
        this.address1,
        this.address2,
        this.suburb,
        this.city,
        this.postcode,
        this.country,
        this.phone,
        this.phonecode,
        this.email,
        this.ordersId,
        this.isDefault,
        this.createdAt,
        this.updatedAt,
        this.fname,
        this.lname,
        this.province,
        this.companyname,
        this.vat});

  Shipaddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    addresstype = json['addresstype'];
    address1 = json['address1'];
    address2 = json['address2'];
    suburb = json['suburb'];
    city = json['city'];
    postcode = json['postcode'];
    country = json['country'];
    phone = json['phone'];
    phonecode = json['phonecode'];
    email = json['email'];
    ordersId = json['orders_id'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fname = json['fname'];
    lname = json['lname'];
    province = json['province'];
    companyname = json['companyname'];
    vat = json['vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['users_id'] = this.usersId;
    data['addresstype'] = this.addresstype;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['suburb'] = this.suburb;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['phonecode'] = this.phonecode;
    data['email'] = this.email;
    data['orders_id'] = this.ordersId;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['province'] = this.province;
    data['companyname'] = this.companyname;
    data['vat'] = this.vat;
    return data;
  }
}

class Billaddress {
  dynamic id;
  dynamic usersId;
  dynamic addresstype;
  dynamic address1;
  dynamic address2;
  dynamic suburb;
  dynamic city;
  dynamic postcode;
  dynamic country;
  dynamic phone;
  dynamic phonecode;
  dynamic email;
  dynamic ordersId;
  dynamic isDefault;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic fname;
  dynamic lname;
  dynamic province;
  dynamic companyname;
  dynamic vat;

  Billaddress(
      {this.id,
        this.usersId,
        this.addresstype,
        this.address1,
        this.address2,
        this.suburb,
        this.city,
        this.postcode,
        this.country,
        this.phone,
        this.phonecode,
        this.email,
        this.ordersId,
        this.isDefault,
        this.createdAt,
        this.updatedAt,
        this.fname,
        this.lname,
        this.province,
        this.companyname,
        this.vat});

  Billaddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    addresstype = json['addresstype'];
    address1 = json['address1'];
    address2 = json['address2'];
    suburb = json['suburb'];
    city = json['city'];
    postcode = json['postcode'];
    country = json['country'];
    phone = json['phone'];
    phonecode = json['phonecode'];
    email = json['email'];
    ordersId = json['orders_id'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fname = json['fname'];
    lname = json['lname'];
    province = json['province'];
    companyname = json['companyname'];
    vat = json['vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['users_id'] = this.usersId;
    data['addresstype'] = this.addresstype;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['suburb'] = this.suburb;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['phonecode'] = this.phonecode;
    data['email'] = this.email;
    data['orders_id'] = this.ordersId;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['province'] = this.province;
    data['companyname'] = this.companyname;
    data['vat'] = this.vat;
    return data;
  }
}

class PaymentModes {
  dynamic title;
  dynamic value;
  dynamic logo;
  dynamic text;

  PaymentModes({this.title, this.value, this.logo, this.text});

  PaymentModes.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
    logo = json['logo'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    data['logo'] = this.logo;
    data['text'] = this.text;
    return data;
  }
}

class Provinces {
  dynamic id;
  dynamic name;
  dynamic provinceCode;

  Provinces({this.id, this.name, this.provinceCode});

  Provinces.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    provinceCode = json['province_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['province_code'] = this.provinceCode;
    return data;
  }
}

class CheckoutArr {
  dynamic name;
  dynamic id;
  dynamic price;
  dynamic category;
  dynamic variant;
  dynamic quantity;

  CheckoutArr(
      {this.name,
        this.id,
        this.price,
        this.category,
        this.variant,
        this.quantity});

  CheckoutArr.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    price = json['price'];
    category = json['category'];
    variant = json['variant'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['price'] = this.price;
    data['category'] = this.category;
    data['variant'] = this.variant;
    data['quantity'] = this.quantity;
    return data;
  }
}
