import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controllers/user_details_controller.dart';
import '../models/common_model.dart';
import '../resources/api_urls.dart';

final userDetailsController = Get.put(UserDetailsController());


Future<CommonModel> addStorePostRepo({
  mapData,
  required String fieldName1,
  required File file1,
  required context,
}) async {

  final token = userDetailsController.userToken.value;
    log("Token being sent: $token");

    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrls.addStorePostUrl));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
    request.headers.addAll(headers);
    request.fields.addAll(mapData);

    if (file1.path.isNotEmpty) {
      String base64Image = base64Encode(await file1.readAsBytes());
      String mimeType = base64Image.endsWith(".png") ? "png" : "jpg";
      String finalBase64String = "data:image/$mimeType;base64,$base64Image";
      request.fields[fieldName1] = finalBase64String;
    }

    log("HEYY ${request.fields.toString()}");
    log("HEYY 1 $fieldName1");
    log("HEYY 2 $file1");
    log(request.files.map((e) => e.filename).toList().toString());
    final response = await request.send();
    String responseString = await response.stream.bytesToString();

    log("Response Status Code: ${response.statusCode}");
    log("Response Body: $responseString");
    if (response.statusCode == 200 || response.statusCode == 400) {
      return CommonModel.fromJson(
          jsonDecode(responseString));
    } else {
      return CommonModel.fromJson(
          jsonDecode(responseString));
    }

}

// for image and video too

Future<CommonModel> vmSectionUploadRepo({
  required Map<String, String> mapData,
  required String fieldName1,
  required File file1,
  required BuildContext context,
}) async {
  final token = userDetailsController.userToken.value;
  log("Token being sent: $token");

  var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.addVMFeedPost));

  request.headers.addAll({
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });

  request.fields.addAll(mapData);
  log("HEYY ${request.fields.toString()}");
  log("HEYY 1 $fieldName1");
  log("HEYY 2 $file1");
  if (file1.path.isNotEmpty) {
    request.files.add(
      await http.MultipartFile.fromPath(
        fieldName1,
        file1.path,
      ),
    );
  }

  final response = await request.send();
  String responseString = await response.stream.bytesToString();

  log("Response Status Code: ${response.statusCode}");
  log("Response Body: $responseString");

  return CommonModel.fromJson(jsonDecode(responseString));
}



Future<http.MultipartFile> multipartFile(String? fieldName1, File file1) async {
  return http.MultipartFile(
    fieldName1 ?? 'file',
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}


