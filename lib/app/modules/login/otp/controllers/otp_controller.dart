import 'dart:async';

import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  // static const maxSeconds = 60;
  var seconds = 0.obs;
  Timer? timer;

  // @override
  // void onInit() {
  //   startCountDown();
  //   super.onInit();
  // }

  void startCountDown() {
    seconds.value = 60;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds--;
        
      } else {
        timer.cancel();
      }
    });
  }
}
