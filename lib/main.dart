import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/controllers/storage_controller.dart';
import 'package:afeefa_handloom/app/widgets/custom_progress_indicator.dart';
import 'package:afeefa_handloom/temp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/constents/colors.dart';
import 'app/routes/app_pages.dart';

void main() async {
  //!Uncomment these lines.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  Get.put(DbController());
  Get.put(StorageController());

  /*
  // Before Working code
  Firebase.initializeApp().then((value) => {
        Get.put(AuthController()),
        Get.put(DbController()),
      });
*/
  runApp(
    MyApp(),
    // MyImagePicker(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textTheme: TextTheme(
          bodyText1: GoogleFonts.baloo(),
          bodyText2: GoogleFonts.baloo2(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "Afeefa Handloom",
      // initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      home: Center(
        child: Scaffold(
          body: Container(
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
      ),
    );
  }
}
