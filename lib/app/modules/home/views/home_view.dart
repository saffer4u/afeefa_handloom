import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constents/colors.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/db_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/Logout_button_widget.dart';
import '../../../widgets/drawer_create_profile_widget.dart';
import '../../../widgets/drawer_menu_button.dart';
import '../../../widgets/drawer_profile_card_widget.dart';
import '../../../widgets/title_widget.dart';
import '../clint_dashbord/views/clint_dashbord_view.dart';
import '../controllers/home_controller.dart';
import '../store/views/store_view.dart';
import 'admin_chat_widget.dart';
import 'clint_chat_view.dart';
import 'clint_create_profile_view.dart';

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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              // Show defferent widget on the basis of user.
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Obx(() {
                  // Top drawer widget.
                  if (Get.find<DbController>().userExist.value) {
                    return DrawerProfileCard();
                  } else {
                    return CreateProfileWidget(
                      onPress: () => Get.toNamed(Routes.CREATE_EDIT_PROFILE),
                    );
                  }
                }),
              ),
              Divider(
                // indent: 30,
                // endIndent: 30,
                height: 0,
                color: royal.withOpacity(0.2),
                thickness: 1,
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Obx(() {
                      if (Get.find<DbController>().userExist.value) {
                        return Column(
                          children: [
                            Get.find<DbController>().userExist.value
                                ? DrawerMenuButton(
                                    icon: Icons.edit,
                                    title: "Update Profile",
                                    onPressed: () => Get.toNamed(Routes.CREATE_EDIT_PROFILE),
                                  )
                                : SizedBox.shrink(),
                            Get.find<DbController>().userProfile.value.isAdmin
                                ? SizedBox.shrink()
                                : DrawerMenuButton(
                                    icon: Icons.dashboard_rounded,
                                    title: "Dashbord",
                                    onPressed: () {
                                      Get.back();
                                      Get.find<HomeController>().clintPageController.jumpToPage(0);
                                    },
                                  ),
                            //! Cart button for clints.
                            Get.find<DbController>().userProfile.value.isAdmin
                                ? SizedBox.shrink()
                                : DrawerMenuButton(
                                    icon: Icons.shopping_cart,
                                    title: "Cart",
                                    onPressed: () => Get.toNamed(Routes.CART),
                                  ),
                            Get.find<DbController>().userProfile.value.isAdmin
                                ? SizedBox.shrink()
                                : DrawerMenuButton(
                                    icon: Icons.category_rounded,
                                    title: "Store",
                                    onPressed: () {
                                      Get.back();
                                      Get.find<HomeController>().clintPageController.jumpToPage(1);
                                    },
                                  ),
                            Get.find<DbController>().userProfile.value.isAdmin
                                ? SizedBox.shrink()
                                : DrawerMenuButton(
                                    icon: Icons.message,
                                    title: "Support",
                                    onPressed: () {
                                      Get.back();
                                      Get.find<HomeController>().clintPageController.jumpToPage(2);
                                    },
                                  ),
                            Get.find<DbController>().userProfile.value.isAdmin
                                ? DrawerMenuButton(
                                    icon: Icons.add_business_rounded,
                                    title: "Add Products",
                                    onPressed: () => Get.toNamed(Routes.ADD_PRODUCT),
                                  )
                                : SizedBox.shrink(),
                            Get.find<DbController>().userProfile.value.isAdmin
                                ? DrawerMenuButton(
                                    icon: Icons.shop_two_rounded,
                                    title: "Inventory",
                                    onPressed: () => Get.toNamed(Routes.INVENTORY),
                                  )
                                : SizedBox.shrink(),
                          ],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                  ),
                ),
              ),
              Divider(
                // indent: 30,
                // endIndent: 30,
                height: 0,
                color: royal.withOpacity(0.2),
                thickness: 1,
              ),
              // Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 15,
                  top: 10,
                ),
                child: LogoutButton(
                  onTap: () {
                    // Logout Call
                    // Get.back();
                    Get.defaultDialog(
                      title: "",
                      contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
              ),
            ]),
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
        title: Obx(() => TitleWidget(title: Get.find<HomeController>().title.value)),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            // print(details.primaryDelta);
            if ((details.primaryDelta! > 15.0)) {
              Scaffold.of(context).openDrawer();
              log(details.delta.toString());
            }
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [slate, concrete],
                begin: Alignment(0, -1),
                end: Alignment(0, 0),
              ),
            ),
            child: SafeArea(
              // Impliment Home Screen logic here...
              child: Obx(() {
                if (Get.find<DbController>().userExist.value) {
                  //  print('See if Admin is true : ${Get.find<DbController>().isAdmin.value}');
                  if (Get.find<DbController>().isAdmin.value) {
                    return AdminChatWidget();
                  } else {
                    return PageView(
                      onPageChanged: (index) {
                        if (index == 0) {
                          Get.find<HomeController>().title.value = "Dashbord";
                        } else if (index == 1) {
                          Get.find<HomeController>().title.value = "Store";
                        } else if (index == 2) {
                          Get.find<HomeController>().title.value = "Support";
                        }
                      },
                      physics: BouncingScrollPhysics(),
                      controller: Get.find<HomeController>().clintPageController,
                      children: [
                        ClintDashbordView(),
                        StoreView(),
                        ClintChatView(),
                      ],
                    );
                  }
                } else {
                  return ClintCreateProfileView();
                }
              }),
            ),
          ),
        );
      }),
    );
  }
}
