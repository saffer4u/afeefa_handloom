import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminChatController extends GetxController {
  late final String docId;
  late final Map<String, dynamic> args;

  TextEditingController messageController = TextEditingController();

  List<String> assignedProducts = [];
  List<Map<String, dynamic>> allAssignedproducts = [];
  @override
  void onInit() async {
    docId = Get.arguments[0];
    args = Get.arguments[1];
    super.onInit();
    await fatchAssignedProducts();
  }

  Future<void> fatchAssignedProducts() async {
    allAssignedproducts = await Get.find<DbController>().getAllAssignedProductList(docId);
    // assignedProducts.addAll();
    // print(products);
    assignedProducts.clear();
    for (var item in allAssignedproducts) {
      assignedProducts.add(item['id']);
    }
    
    print('Fatch assign product is called');
    update();
  }

  Future<void> sendMessage() async {
    //! Can change map data if required
    await Get.find<DbController>().sendMessage(docId: docId, data: {
      'message': messageController.text.trim(),
      'createdAt': DateTime.now(),
      'type': 'message',
      'byAdmin': true,
    });

    messageController.clear();
    await Get.find<DbController>().changeLastMessageTime(docId: docId);
  }
}
