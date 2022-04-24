import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../../../controllers/db_controller.dart';

class StoreController extends GetxController {
  List<String> assignedProducts = [];
  List<Map<String, dynamic>> allAssignedproducts = [];
  Future<void> fatchAssignedProducts() async {
    allAssignedproducts = await Get.find<DbController>().getAllAssignedProductList(
      Get.find<AuthController>().getUid,
    );
    // assignedProducts.addAll();
    // print(products);
    assignedProducts.clear();
    for (var item in allAssignedproducts) {
      assignedProducts.add(item['id']);
    }

    print('Fatch assign product is called');
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fatchAssignedProducts();
  }
}
