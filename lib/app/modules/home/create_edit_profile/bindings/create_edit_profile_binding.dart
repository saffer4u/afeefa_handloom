import 'package:get/get.dart';

import '../controllers/create_edit_profile_controller.dart';

class CreateEditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateEditProfileController>(
      () => CreateEditProfileController(),
    );
  }
}
