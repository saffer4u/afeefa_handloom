import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:afeefa_handloom/app/modules/home/controllers/clint_chat_controller.dart';
import 'package:afeefa_handloom/app/modules/home/store/controllers/store_controller.dart';

import 'package:get/get.dart';

import '../../../controllers/db_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
    Get.put(HomeController());

    if (!Get.find<DbController>().isAdmin.value) {
      Get.put(ClintChatController());
      Get.put(StoreController());
      
    }
  }
}
