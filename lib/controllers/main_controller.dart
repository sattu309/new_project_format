import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeController extends GetxController {
  Rx<File> image = File("").obs;
  Rx<File> vmSectionImage = File("").obs;
  // RxString base64Value = "".obs;
  Rx<File> base64Value = File("").obs;
  RxInt currentIndex = 0.obs;
  RxBool internetConnection = true.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  onItemTap(int value) {
    currentIndex.value = value;
  }
}
