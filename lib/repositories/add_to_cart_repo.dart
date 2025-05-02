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


Future<ProductDetailModel> searchProductRepo({
  required String productCode,
  required BuildContext context}
    ) async {

  var map = <String, dynamic>{};
  map['productcode'] = productCode;
  log(map.toString());
  var token = userDetailsController.userToken.value;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'

  };
  log('REQUEST ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.searchProductUrl),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    return ProductDetailModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

Future<CommonModel> addToCartRepo({
  required String qty,

  required String productVariantId,
  required String productId,

  required BuildContext context}
    ) async {
  var token = userDetailsController.userToken.value;
  var sesionId = userDetailsController.appSessionId.value;
  var map = <String, dynamic>{};
  map['qty'] = qty;
  map['session_id'] = sesionId;
  map['productvariant_id'] = productVariantId;
  map['product_id'] = productId;
  map['cartaction'] = "add";
  log(map.toString());


  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'

  };
  log('REQUEST ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.addToCartUrl),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    return CommonModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

Future<CommonModel> updateCartRepo({
  required String qty,
  required String productVariantId,
  required String productId,

  required BuildContext context}
    ) async {
  var token = userDetailsController.userToken.value;
  var sesionId = userDetailsController.appSessionId.value;
  var map = <String, dynamic>{};
  map['qty'] = qty;
  map['session_id'] = sesionId;
  map['productvariant_id'] = productVariantId;
  map['product_id'] = productId;
  map['cartaction'] = "update";
  log(map.toString());


  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'

  };
  log('REQUEST ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.addToCartUrl),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    return CommonModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
