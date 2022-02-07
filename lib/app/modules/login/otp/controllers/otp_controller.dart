import 'dart:async';

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
