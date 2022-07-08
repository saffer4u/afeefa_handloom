import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/constents/colors.dart';
import 'app/controllers/auth_controller.dart';
import 'app/controllers/db_controller.dart';
import 'app/controllers/storage_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/widgets/custom_progress_indicator.dart';

//? Problems :
//! Impliment logic to delete product from main Inventory as well as assigned product.
//! Push notificaiton is not implimented.
//! lastMessageTime of user_profile_model may affect on new user creation or update user profile.
////// User profile did not get updated after updating profile : Solved by Restarting app.
//! Admin chat stream builder controller get closed when update profile.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  Get.put(DbController());
  Get.put(StorageController());

  runApp(
    MyApp(),
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
            headline3: GoogleFonts.baloo(
              fontSize: 20,
              color: slate,
            )),
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
