import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/widgets/create_profile_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 5,
          left: 5,
          bottom: 5,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                slate,
                concrete,
              ],
              begin: Alignment(0, -1),
              end: Alignment(0, 0),
            ),
          ),
          child: Drawer(
            elevation: 0,
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListView(padding: EdgeInsets.all(20), children: [
              CreateProfileWidget(),
              ListTile(title: Text("Home"))
            ]),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: Get.find<AuthController>().logOut,
        // onPressed:()=>print(Get.find<AuthController>().getCurrentUserInfo().toString()),
        // onPressed: () => print(Get.find<AuthController>().getUid),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: royal,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [slate, concrete],
            begin: Alignment(0, -1),
            end: Alignment(0, 0),
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Obx(() => Text(
                  'Admin : ${Get.find<DbController>().userData.value}, : ${Get.find<DbController>().isAdmin.value}',
                  style: TextStyle(fontSize: 20),
                )),
          ),
        ),
      ),
    );
  }
}

