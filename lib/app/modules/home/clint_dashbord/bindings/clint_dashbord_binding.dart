import 'package:get/get.dart';

import '../controllers/clint_dashbord_controller.dart';

class ClintDashbordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClintDashbordController>(
      () => ClintDashbordController(),
    );
  }
}
