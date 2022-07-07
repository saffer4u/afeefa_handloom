import 'package:get/get.dart';

import '../controllers/clint_show_product_controller.dart';

class ClintShowProductBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.put<ClintShowProductController>(ClintShowProductController());
  }
}
