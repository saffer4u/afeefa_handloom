import 'dart:developer';

import 'package:get/get.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/db_controller.dart';

class StoreController extends GetxController {
  List<String> assignedProducts = [];
  List<Map<String, dynamic>> allAssignedproducts = [];
  Future<void> fatchAssignedProducts() async {
    allAssignedproducts = await Get.find<DbController>().getAllAssignedProductList(
      Get.find<AuthController>().getUid,
    );
 
    assignedProducts.clear();
    for (var item in allAssignedproducts) {
      assignedProducts.add(item['id']);
    }

    log('Fatch assign product is called');
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await fatchAssignedProducts();
  }
}
