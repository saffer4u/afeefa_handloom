import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/db_controller.dart';
import '../../../widgets/snakbars.dart';

class HomeController extends GetxController {
  var title = "Afeefa Handloom".obs;
  PageController clint_page_controller = PageController(
    initialPage: 0,
  );

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
