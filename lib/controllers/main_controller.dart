import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeController extends GetxController {
  Rx<File> image = File("").obs;
  Rx<File> vmSectionImage = File("").obs;
  Rx<File> vmSectionReplyImg = File("").obs;
  RxString vmSectionImageType = "".obs;
  Rx<File> base64Value = File("").obs;
  RxInt currentIndex = 0.obs;
  RxList<String> correctAnswerList = <String>[].obs;
  RxBool internetConnection = true.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  onItemTap(int value) {
    currentIndex.value = value;
  }
}
