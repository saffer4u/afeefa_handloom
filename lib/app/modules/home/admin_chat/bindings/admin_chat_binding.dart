import 'package:get/get.dart';

import '../admin_assign_product/controllers/admin_assign_product_controller.dart';
import '../controllers/admin_chat_controller.dart';

class AdminChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAssignProductController>(
      () => AdminAssignProductController(),
    );
    Get.put(AdminChatController());
    // Get.lazyPut<AdminChatController>(
    //   () => AdminChatController(),
    // );
  }
}
