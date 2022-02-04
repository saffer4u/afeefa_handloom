import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateEditProfileController extends GetxController {
  TextEditingController userNameController = TextEditingController();

  var userTypeDropDownItems =
      Get.find<DbController>().configData.value.userType;
  var userTypeDropDownValue =
      Get.find<DbController>().configData.value.userType[0].obs;
}
