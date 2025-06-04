import 'dart:convert';
import 'package:get/get.dart';
import '../common_repository/common_api_method.dart';
import '../models/notification_model.dart';
import '../models/stores_list.dart';
import '../models/vm_section_List_model.dart';
import '../resources/api_urls.dart';
import '../models/dashboard_model.dart';


class StoreController extends GetxController {
  RxString notiCount = "".obs;
  var isDataLoading = false.obs;
  var model = GetStoreListModel().obs;
  var notificationModel = NotificationListModel().obs;
  var vmSectionListModel = VmSectionListModel().obs;
  var dashboradModel = DashboradModel().obs;
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
  Future<void> getVmSectionList() async {
    try {
      isDataLoading(true);
      var response = await repository.getApi(url: ApiUrls.getVmSectionListUrl);
      vmSectionListModel.value = VmSectionListModel.fromJson(jsonDecode(response));
    } catch (e) {
      print("Error fetching store data: $e");
    } finally {
      isDataLoading(false);
    }
  }

  Future<void> getNotificationList() async {
    try {
      isDataLoading(true);
      var response = await repository.getApi(url: ApiUrls.getNotificationList);
      notificationModel.value = NotificationListModel.fromJson(jsonDecode(response));
      notiCount.value = notificationModel.value.unreadnotifications.toString();
    } catch (e) {
      print("Error fetching notification data: $e");
    } finally {
      isDataLoading(false);
    }
  }
  // stores data
  Future<void> getStoresDasboardData() async {
    print("From store data ");
    try {
      isDataLoading(true);
      var response = await repository.getApi(url: ApiUrls.dashBoardUrl);
      dashboradModel.value = DashboradModel.fromJson(jsonDecode(response));
    } catch (e) {
      print("Error fetching notification data: $e");
    } finally {
      isDataLoading(false);
    }
  }
  @override
  void onInit() {
    super.onInit();
    getStoresDasboardData();
  }

}
