import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController phoneNumberController = TextEditingController();
  late AnimationController animation;
  late Animation<double> fadeInFadeOut;

  @override
  void onClose() {
    animation.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
    animation.forward();
    super.onInit();
  }
}
