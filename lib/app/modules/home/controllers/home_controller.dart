import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late Map<String, String?> currentUser;

  @override
  void onInit() {
    currentUser = Get.find<AuthController>().getCurrentUserInfo();
    Get.find<DbController>().createNewUser(currentUser);

    super.onInit();
  }
}
