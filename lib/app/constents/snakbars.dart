import 'package:get/get.dart';

class Snakebars {
  void errorBar(String msg) {
    Get.snackbar("Error", msg,snackPosition: SnackPosition.BOTTOM);
  }
}
