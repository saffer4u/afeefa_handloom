import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:afeefa_handloom/app/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';

import 'app/constents/colors.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => {Get.put(AuthController())});

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Afeefa Handloom",
      // initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      home: Center(
          child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [slate, concrete],
                begin: Alignment(0, -1),
                end: Alignment(0, 0),
                
              ),
            ),
            child: CustomProgressIndicator(),
          ),
        ),
      )),
    ),
  );
}
