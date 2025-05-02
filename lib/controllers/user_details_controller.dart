import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulid/ulid.dart';
import '../models/user_details_model.dart';

class UserDetailsController extends GetxController{
  RxString errorText="".obs;
  RxString errorText1="".obs;
  var userId = "".obs;
  var userName = "".obs;
  var userRoles = "".obs;
  var userToken = "".obs;
  var appSessionId = "".obs;
  getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("user_details");
    log("LOCAL USER DATA ${userInfo}");

    if (userInfo == null) {
      log("No user info found in local storage.");
      throw Exception("User info not found.");
    }
    // Map<String, dynamic> userDataMap = jsonDecode(userInfo);
    // log("Decoded user data: $userDataMap");
    UserDetailsModel userDetailsModel = UserDetailsModel.fromJson(jsonDecode(userInfo));
    userId.value = userDetailsModel.id.toString();
    userRoles.value = userDetailsModel.role.toString();
    userToken.value = userDetailsModel.token.toString();
    userName.value = userDetailsModel.name.toString();
    appSessionId.value = Ulid().toString();
    print(Ulid());
    print(Ulid().toUuid());
    log("USER ID ${userId.value.toString()}");
    log("USER ROLES ${userRoles.value.toString()}");
    log("userToken ID ${userToken.value.toString()}");
    log("appSessionId ID ${appSessionId.value.toString()}");
  }
  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }
}