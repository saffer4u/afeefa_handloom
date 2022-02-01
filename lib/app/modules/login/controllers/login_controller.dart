import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void onClose() {
    phoneNumberController.dispose();
    super.onClose();
  }
}
