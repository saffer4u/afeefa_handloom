import 'package:afeefa_handloom/app/controllers/db_controller.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../add_product/model/product.dart';

class InventoryController extends GetxController {
  @override
  void onInit() async {
    // await getAllProducts();
    super.onInit();
  }

  List<Product> allProducts = [];

  // Future<void> getAllProducts() async {
  //   allProducts = await Get.find<DbController>().getAllProductsInCollection('products');
  //   for (var item in allProducts) {
  //     print(item.images);
  //   }
  //   update();
  // }
}
