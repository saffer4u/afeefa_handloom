import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/widgets/snakbars.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // late Map<String, String?> currentUser;

  // @override
  // void onInit(){
  //   // currentUser = Get.find<AuthController>().getCurrentUserInfo();
  //   // Get.find<DbController>().createNewUser(currentUser);
  //   // Get.find<DbController>().checkIsAdmin(Get.find<AuthController>().getUid);
  //   // Get.find<DbController>().getUserData(Get.find<AuthController>().getUid);

  //   super.onInit();
  // }

  @override
  void onInit() async {
   
    super.onInit();
  }

  @override
  void onReady() async {
    await Future.delayed(Duration(seconds: 10));
    if (!Get.find<DbController>().userExist.value) {
      customBar(
        title: "Please Create your Profile",
        duration: 2,
      );
    }
    super.onReady();
  }
}
