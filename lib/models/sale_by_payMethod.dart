class SaleByPayMethodModel {
  Success? success;

  SaleByPayMethodModel({this.success});

  SaleByPayMethodModel.fromJson(Map<String, dynamic> json) {
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
  PaymethodRep? paymethodRep;

  Success({this.paymethodRep});

  Success.fromJson(Map<String, dynamic> json) {
    paymethodRep = json['paymethodRep'] != null
        ? new PaymethodRep.fromJson(json['paymethodRep'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymethodRep != null) {
      data['paymethodRep'] = this.paymethodRep!.toJson();
    }
    return data;
  }
}

class PaymethodRep {
  TODAY? tODAY;
  TODAY? yESTERDAY;
  TODAY? dAYBEFOREYESTERDAY;
  TODAY? t2DAYSBEFOREYESTERDAY;
  TODAY? cURRENTWEEK;
  TODAY? cURRENTMONTH;

  PaymethodRep(
      {this.tODAY,
        this.yESTERDAY,
        this.dAYBEFOREYESTERDAY,
        this.t2DAYSBEFOREYESTERDAY,
        this.cURRENTWEEK,
        this.cURRENTMONTH});

  PaymethodRep.fromJson(Map<String, dynamic> json) {
    tODAY = json['TODAY'] != null ? new TODAY.fromJson(json['TODAY']) : null;
    yESTERDAY = json['YESTERDAY'] != null
        ? new TODAY.fromJson(json['YESTERDAY'])
        : null;
    dAYBEFOREYESTERDAY = json['DAY BEFORE YESTERDAY'] != null
        ? new TODAY.fromJson(json['DAY BEFORE YESTERDAY'])
        : null;
    t2DAYSBEFOREYESTERDAY = json['2 DAYS BEFORE YESTERDAY'] != null
        ? new TODAY.fromJson(json['2 DAYS BEFORE YESTERDAY'])
        : null;
    cURRENTWEEK = json['CURRENT WEEK'] != null
        ? new TODAY.fromJson(json['CURRENT WEEK'])
        : null;
    cURRENTMONTH = json['CURRENT MONTH'] != null
        ? new TODAY.fromJson(json['CURRENT MONTH'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tODAY != null) {
      data['TODAY'] = this.tODAY!.toJson();
    }
    if (this.yESTERDAY != null) {
      data['YESTERDAY'] = this.yESTERDAY!.toJson();
    }
    if (this.dAYBEFOREYESTERDAY != null) {
      data['DAY BEFORE YESTERDAY'] = this.dAYBEFOREYESTERDAY!.toJson();
    }
    if (this.t2DAYSBEFOREYESTERDAY != null) {
      data['2 DAYS BEFORE YESTERDAY'] = this.t2DAYSBEFOREYESTERDAY!.toJson();
    }
    if (this.cURRENTWEEK != null) {
      data['CURRENT WEEK'] = this.cURRENTWEEK!.toJson();
    }
    if (this.cURRENTMONTH != null) {
      data['CURRENT MONTH'] = this.cURRENTMONTH!.toJson();
    }
    return data;
  }
}

class TODAY {
  OZOW? dIRECT;
  OZOW? oZOW;
  OZOW? tFG;
  OZOW? pAYU;
  OZOW? pAYJUSTNOW;
  OZOW? pAYFAST;

  TODAY(
      {this.dIRECT,
        this.oZOW,
        this.tFG,
        this.pAYU,
        this.pAYJUSTNOW,
        this.pAYFAST});

  TODAY.fromJson(Map<String, dynamic> json) {
    dIRECT = json['DIRECT'] != null ? new OZOW.fromJson(json['DIRECT']) : null;
    oZOW = json['OZOW'] != null ? new OZOW.fromJson(json['OZOW']) : null;
    tFG = json['TFG'] != null ? new OZOW.fromJson(json['TFG']) : null;
    pAYU = json['PAYU'] != null ? new OZOW.fromJson(json['PAYU']) : null;
    pAYJUSTNOW = json['PAYJUSTNOW'] != null
        ? new OZOW.fromJson(json['PAYJUSTNOW'])
        : null;
    pAYFAST =
    json['PAYFAST'] != null ? new OZOW.fromJson(json['PAYFAST']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dIRECT != null) {
      data['DIRECT'] = this.dIRECT!.toJson();
    }
    if (this.oZOW != null) {
      data['OZOW'] = this.oZOW!.toJson();
    }
    if (this.tFG != null) {
      data['TFG'] = this.tFG!.toJson();
    }
    if (this.pAYU != null) {
      data['PAYU'] = this.pAYU!.toJson();
    }
    if (this.pAYJUSTNOW != null) {
      data['PAYJUSTNOW'] = this.pAYJUSTNOW!.toJson();
    }
    if (this.pAYFAST != null) {
      data['PAYFAST'] = this.pAYFAST!.toJson();
    }
    return data;
  }
}

class DIRECT {
  dynamic amount;
  dynamic orders;

  DIRECT({this.amount, this.orders});

  DIRECT.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    orders = json['orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['orders'] = this.orders;
    return data;
  }
}

class OZOW {
  dynamic amount;
  dynamic orders;

  OZOW({this.amount, this.orders});

  OZOW.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    orders = json['orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['orders'] = this.orders;
    return data;
  }
}
