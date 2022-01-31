import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => {
    Get.put(AuthController())
  });

  runApp(
    GetMaterialApp(
      title: "Afeefa Handloom",
      // initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      home: Center(child: CircularProgressIndicator()),
    ),
  );
}
