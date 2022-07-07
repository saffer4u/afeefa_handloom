

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/db_controller.dart';
import '../../controllers/admin_chat_controller.dart';

class AdminAssignProductController extends GetxController {
  TextEditingController rateController = TextEditingController();

  // Assign products to clint
  Future<void> assignProduct(String productId) async {
    await Get.find<DbController>().assignProduct(docId: Get.find<AdminChatController>().docId, data: {
      'id': productId,
      'assignPrice': rateController.text.isEmpty?0:int.parse(rateController.text),
      'assignTime': DateTime.now(),
    });
  }
}
