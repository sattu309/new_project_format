import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/user_details_controller.dart';
import '../drawer_menu/shop-Section/cart_model.dart';
import '../drawer_menu/shop-Section/checkout_setting_model.dart';
import '../models/stores_list.dart';
import '../resources/api_urls.dart';


Future<GetCartModel> getCartData() async {
  final userDetailsController = Get.put(UserDetailsController());
  var map = <String, dynamic>{};
  map['session_id']=userDetailsController.appSessionId.value;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${userDetailsController.userToken.value}'
  };
  http.Response response =
  await http.post(Uri.parse(ApiUrls.getCartDataUrl), headers: headers,body: jsonEncode(map));

  if (response.statusCode == 200) {
    print("CART DATA ${response.body}");
    return GetCartModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

Future<CheckoutSettingModel> getCheckoutSettingData() async {
  final userDetailsController = Get.put(UserDetailsController());
  var map = <String, dynamic>{};
  map['sessionid']=userDetailsController.appSessionId.value;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${userDetailsController.userToken.value}'
  };
  http.Response response =
  await http.get(Uri.parse(ApiUrls.getCheckoutSettingUrl), headers: headers,);

  if (response.statusCode == 200) {
    log("CHECKOUT  DATA ${response.body}");
    return CheckoutSettingModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}