import 'package:afeefa_handloom/app/widgets/Logout_button_Widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/widgets/create_profile_widget.dart';

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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                // Show defferent widget on the basis of user.
                Builder(builder: (context) {
                  return CreateProfileWidget(
                    onPress: () {},
                  );
                }),
                Divider(),
                ListTile(
                  title: Text("Home"),
                ),
                Spacer(),
                LogoutButton(
                  onTap: () {
                    // Logout Call
                    // Get.back();
                    Get.defaultDialog(
                      title: "",
                      contentPadding:
                          EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      content: Column(
                        children: [
                          Text(
                            "Log Out",
                            style: GoogleFonts.baloo(
                              color: royal,
                              fontSize: 35,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GradientText(
                            "Are you sure?",
                            style: GoogleFonts.baloo2(
                              color: royal,
                              fontSize: 15,
                            ),
                            colors: [redOrenge, royal],
                          ),
                        ],
                      ),
                      backgroundColor: slate,
                      actions: [
                        TextButton(
                            onPressed: () {
                              Get.back();
                              // Snakebars().errorBar(
                              //     'This is a test message to test and design the snakebar.');
                            },
                            child: Text(
                              'NO',
                              style: GoogleFonts.baloo(
                                color: royal.withOpacity(0.8),
                                fontSize: 20,
                              ),
                            )),
                        TextButton(
                            onPressed: Get.find<AuthController>().logOut,
                            child: Text(
                              'YES',
                              style: GoogleFonts.baloo(
                                color: royal,
                                fontSize: 20,
                              ),
                            )),
                      ],
                    );
                  },
                ),
              ]),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
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
