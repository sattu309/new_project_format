import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:volpes/models/common_model.dart';

import '../controllers/user_details_controller.dart';
import '../models/otp_requested_model.dart';
import '../models/verify_otp_model.dart';
import '../resources/api_urls.dart';
import '../resources/common_texts_style.dart';

final userDetailsController = Get.put(UserDetailsController());
Future<RequestOtpModel> createLogin(
    {required String email,
      required BuildContext context}) async {

  var map = <String, dynamic>{};
  map['email'] = email;
  map['mailtype'] = "login";
  log(map.toString());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',

  };
  print('REQUEST ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.loginUrl),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    // showSnackBarView(context: context, msg: response.body.toString(), bgColor: Colors.white);
    return RequestOtpModel.fromJson(json.decode(response.body));
  } else {
    final Map<String, dynamic> errorData = jsonDecode(response.body);
    userDetailsController.errorText.value = errorData['error'];
    // showSnackBarView(context: context, msg: errorData['error'], bgColor: Colors.white);
    throw Exception(response.body);
  }
}

Future<CommonModel> sendFCMTokenRepo({
  required String fcmToken,
  required String token,

}) async {
  var map = <String, dynamic>{};
  map['fcm'] = fcmToken;

  log(map.toString());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader:'Bearer $token'
  };
  print('REQUEST ::${jsonEncode(map)}');
  print('HEADER ::${jsonEncode(headers)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.sendFcmTokenUrl),
      body: jsonEncode(map), headers: headers);
  log("TOKEN response....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    return CommonModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

Future<VerifyOtpModel> otpVerifyRepo(
    {
      required String email,
      required String otp,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['email'] = email;
  map['mailtype'] = "login";
  map['otpData'] = otp;
  log(map.toString());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  print('REQUEST ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.verifyOtpUrl),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    return VerifyOtpModel.fromJson(json.decode(response.body));

  } else {
    final Map<String, dynamic> errorData = jsonDecode(response.body);
    userDetailsController.errorText1.value = errorData['error'];
    throw Exception(response.body);
  }
}


Future<CommonModel> updatePackageContent(
    {
      required String stockId,
      required String salesPerson,
      required String storeComment,
      required String updateDate,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['stock_id'] = stockId;
  map['sales_person'] = salesPerson;
  map['storecomment'] = storeComment;
  map['updated_date'] = updateDate;
  log(map.toString());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${userDetailsController.userToken.value}',
  };
  print(headers);
  print('REQUEST ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.updatePackageUrl),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    return CommonModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

Future<CommonModel> feedbackFormRepo(
    {
      required String title,
      required String feedback,

      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['title'] = title;
  map['feedback'] = feedback;

  log(map.toString());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${userDetailsController.userToken.value}',
  };
  print(headers);
  print('REQUEST ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.feedbackFormUrl),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    return CommonModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}