import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/db_controller.dart';

class ClintChatController extends GetxController {
  TextEditingController messageController = TextEditingController();

  Future<void> sendMessage() async {
    //! Can change map data if required
    await Get.find<DbController>().sendMessage(docId: Get.find<AuthController>().getUid, data: {
      'message': messageController.text.trim(),
      'createdAt': DateTime.now(),
      'type': 'message',
      'byAdmin': false,
    });

    messageController.clear();
    await Get.find<DbController>().changeLastMessageTime(docId:  Get.find<AuthController>().getUid);
  }
}
