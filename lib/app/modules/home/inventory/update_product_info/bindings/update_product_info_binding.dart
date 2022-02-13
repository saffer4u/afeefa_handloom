import 'package:get/get.dart';

import '../controllers/update_product_info_controller.dart';

class UpdateProductInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateProductInfoController>(
      () => UpdateProductInfoController(),
    );
  }
}
