import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/user_details_controller.dart';
import '../resources/api_urls.dart';
import '../store pages/quiz_component/pdf_view.dart';

Future<void> getTestResultPdfLink({required String pdfId,required  context}) async {
  final userDetailsController = Get.put(UserDetailsController());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${userDetailsController.userToken.value}'
  };
  http.Response response =
  await http.get(Uri.parse("${ApiUrls.getTestReusltPdfLink}/$pdfId"), headers: headers);

  if (response.statusCode == 200) {
    final pdfBytes = response.bodyBytes;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(pdfBytes: pdfBytes),
      ),
    );
  } else {
    throw Exception(response.body);
  }
}