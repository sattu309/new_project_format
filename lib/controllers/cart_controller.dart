
import 'dart:developer';

import 'package:get/get.dart';
import 'package:volpes/repositories/start_quiz_repo.dart';

import '../drawer_menu/shop-Section/cart_model.dart';
import '../drawer_menu/shop-Section/checkout_setting_model.dart';
import '../repositories/cart_&_checkout_repos.dart';

class CartController extends GetxController{
  List<String> salesPersonList = [];
  List<String> provinceList = [];
  var selectedId = {};
  var cartModel = GetCartModel().obs;
  var checkoutModel = CheckoutSettingModel().obs;
  var isDataLoading = false.obs;
  RxDouble cartTotal = 0.0.obs;
  Future<void> getData() async {
    try {
      isDataLoading(true);
      await getCartData().then((value) {
        cartModel.value = value;
        cartTotal.value = 0.0; // reset before summing
        for (var product in cartModel.value.success?.products ?? []) {
          cartTotal.value += product.amount ?? 0.0;
        }
        log("CART TOTAL ${cartTotal.toString()}");
        log("CART ${cartModel.value.toString()}");
      });
    } catch (e) {
      print("Error fetching cart data: $e");
    } finally {
      isDataLoading(false);
    }
  }
  //CHEKCOUT DATA
  Future<void> getCHECKOUTData() async {
    try {
      isDataLoading(true);
      await getCheckoutSettingData().then((value) {
        checkoutModel.value = value;
        selectedId.clear();
        for(var person in checkoutModel.value.success!.salespersons ?? []){
            String fullName = "${person.firstName ?? ""} ${person.lastName ?? ""}".trim();
            String id = person.iD.toString();
            selectedId[fullName]=id;
            salesPersonList.add(fullName);
            log("SALEPERSON ID ${selectedId.toString()}");
          // salesPersonList.add("${person.name} ${person.lastName}");
          log("LIST::: ${salesPersonList}");
        }
        for(var person in checkoutModel.value.success!.provinces ?? []){
            String fullName = "${person.name ?? ""}".trim();
            provinceList.add(fullName);
            log("SALEPERSON ID ${selectedId.toString()}");
          // salesPersonList.add("${person.name} ${person.lastName}");
          log("PROVINCE::: ${provinceList}");
        }
      });
    } catch (e) {
      print("Error fetching checkoutModel data: $e");
    } finally {
      isDataLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    getCHECKOUTData();
  }
}