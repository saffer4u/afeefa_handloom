import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // late Map<String, String?> currentUser;

  

  @override
  void onInit(){
    // currentUser = Get.find<AuthController>().getCurrentUserInfo();
    // Get.find<DbController>().createNewUser(currentUser);
    // Get.find<DbController>().checkIsAdmin(Get.find<AuthController>().getUid);
    // Get.find<DbController>().getUserData(Get.find<AuthController>().getUid);

    super.onInit();
  }
}
