import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:volpes/models/common_model.dart';
import '../controllers/user_details_controller.dart';
import '../models/product_detail_model.dart';
import '../resources/api_urls.dart';

final userDetailsController = Get.put(UserDetailsController());

Future<PlaceOrderModel> placeOrderREpo({
  required String email,
  required String phone,
  required String phoneCode,
  required String fName,
  required String lName,
  required String companyName,
  required String vat,
  required String address1,
  required String address2,
  required String suburb,
  required String city,
  required String country,
  required String postCode,
  required String province,
  required String custFName,
  required String custLName,
  required String custEmail,
  required String custPHone,
  required String custPhoneCode,
  required String storeInStock,
  required String shipToCust,
  required String newsLetter1,
  required String smsSUB,
  required String shipStoreId,
  required String deliveryAdd,
  required String bEmail,
  required String bPhone,
  required String bPhoneCode,
  required String bFName,
  required String bLName,
  required String bCompanyName,
  required String bAddres1,
  required String bAddres2,
  required String bSuburb,
  required String bCity,
  required String bCountry,
  required String bPostCode,
  required String bProvince,
  required String comPoptDisp,
  required String sameBillShip,
  required String newLetter2,
  required String smsSub2,
  required String compoptDispStore,
  required String salesPerson,
  required String prdTotalAmt,
  required String totalAmt,
  required String shipAmt,
  required String discount,
  required String discountString,
  required String couponAmt,
  required String couponId,
  required String coupon,
  required String payMent,

  // required String productVariantId,
  // required String productId,

  required BuildContext context}
    ) async {
  var token = userDetailsController.userToken.value;
  var sesionId = userDetailsController.appSessionId.value;
  var map = <String, dynamic>{};
  map['action'] = "order";
  map['email'] = email;
  map['phone'] = phone;
  map['phonecode'] = phoneCode;
  map['fname'] = fName;
  map['lname'] = lName;
  map['companyname'] = companyName;
  map['vat'] = vat;
  map['address1'] = address1;
  map['address2'] = address2;
  map['suburb'] = suburb;
  map['city'] = city;
  map['country'] = country;
  map['postcode'] = postCode;
  map['province'] = province;
  map['custfname'] = custFName;
  map['custlname'] = custLName;
  map['custemail'] = custEmail;
  map['custphone'] = custPHone;
  map['custphonecode'] = custPhoneCode;
  map['storeinstock'] = storeInStock;
  map['shiptocust'] = shipToCust;
  map['newsletter1'] = newsLetter1;
  map['smssub1'] = smsSUB;
  map['shipstore_id'] = shipStoreId;
  map['deliveryadd'] = deliveryAdd;

  map['bemail'] = bEmail;
  map['bphone'] = bPhone;
  map['bphoneCode'] = bPhoneCode;
  map['bfname'] = bFName;
  map['blname'] = bLName;
  map['bcompanyname'] = bCompanyName;
  map['baddress1'] = bAddres1;
  map['baddress2'] = bAddres2;
  map['bsuburb'] = bSuburb;
  map['bcity'] = bCity;
  map['bcountry'] = bCountry;
  map['bpostcode'] = bPostCode;
  map['bprovince'] = bProvince;
  map['compoptdisp'] = comPoptDisp;
  map['samebillship'] = sameBillShip;
  map['newsletter2'] = newLetter2;
  map['smssub2'] = smsSub2;
  map['compoptdispstore'] = compoptDispStore;
  map['salesperson'] = salesPerson;
  map['updatecart'] = sesionId;
  map['prdtotalAmt'] = prdTotalAmt;
  map['totalAmt'] = totalAmt;
  map['shipamount'] = shipAmt;
  map['discount'] = discount;
  map['discount_string'] = discountString;
  map['couponamount'] = couponAmt;
  map['coupon_id'] = couponId;
  map['coupon'] = coupon;
  map['payment'] = payMent;

  // map['session_id'] = sesionId;


  log(map.toString());


  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'

  };
  log('REQUEST ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.placeOrderUrl),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    return PlaceOrderModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

