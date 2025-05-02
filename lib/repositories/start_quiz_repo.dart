import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/user_details_controller.dart';
import '../drawer_menu/shop-Section/cart_model.dart';
import '../models/stores_list.dart';
import '../resources/api_urls.dart';

Future<GetStoreListModel> getStoreList(context) async {
  final userDetailsController = Get.put(UserDetailsController());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${userDetailsController.userToken.value}'
  };
  http.Response response =
  await http.get(Uri.parse(ApiUrls.getStoreList), headers: headers);

  if (response.statusCode == 200) {
    print("<<<<<<<Stores List=======>${response.body}");
    return GetStoreListModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

