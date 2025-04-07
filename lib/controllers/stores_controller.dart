// import 'package:get/get.dart';
// import '../common_repository/common_api_method.dart';
// import 'dart:convert';
//
// import '../models/stores_list.dart';
// import '../repositories/start_quiz_repo.dart';
// import '../resources/api_urls.dart';
//
// class StoreController extends GetxController {
//   final Repositories repository = Repositories();
//
//   // var getStoreListModel = GetStoreListModel().obs;
//   // var isLoading = false.obs;
//   //
//   // Future<void> getStoresList() async {
//   //   try {
//   //     isLoading.value = true;
//   //     var response = await repository.getApi(url: ApiUrls.getStoreList);
//   //     getStoreListModel.value = GetStoreListModel.fromJson(jsonDecode(response));
//   //   } catch (e) {
//   //     print("Error fetching store list: $e");
//   //   }
//   // }
//
//   RxBool isDataLoading = false.obs;
//   Rx<GetStoreListModel> model = GetStoreListModel().obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     getData();
//   }
//
//   getData() async {
//     isDataLoading.value = false;
//     getStoreList(Get.context).then((value) {
//       isDataLoading.value = true;
//       model.value = value;
//     });
//   }
//
// }
import 'dart:convert';

import 'package:get/get.dart';

import '../common_repository/common_api_method.dart';
import '../models/stores_list.dart';
import '../resources/api_urls.dart';

class StoreController extends GetxController {
  var isDataLoading = false.obs;
  var model = GetStoreListModel().obs;
  final Repositories repository = Repositories();

  Future<void> getData() async {
    try {
      isDataLoading(true);
      var response = await repository.getApi(url: ApiUrls.getStoreList);
      model.value = GetStoreListModel.fromJson(jsonDecode(response));
    } catch (e) {
      print("Error fetching store data: $e");
    } finally {
      isDataLoading(false);
    }
  }
}
