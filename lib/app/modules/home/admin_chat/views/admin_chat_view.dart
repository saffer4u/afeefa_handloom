import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/modules/home/admin_chat/admin_assign_product/bindings/admin_assign_product_binding.dart';
import 'package:afeefa_handloom/app/modules/home/admin_chat/admin_assign_product/views/admin_assign_product_view.dart';
import 'package:afeefa_handloom/app/modules/home/admin_chat/views/admin_new_message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../constents/colors.dart';
import '../../../../widgets/custom_network_image_widget.dart';
import '../../../../widgets/title_widget.dart';
import '../controllers/admin_chat_controller.dart';
import 'chat_page.dart';

class AdminChatView extends GetView<AdminChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      elevation: 5,
                      contentPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      content: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(
                          //     offset: Offset(2, 2),
                          //     color: Colors.grey,
                          //     blurRadius: 5.0,
                          //   ),
                          // ],
                          color: concrete,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: slate.withOpacity(0.2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomNetworkImageWidget(
                                    url: Get.find<AdminChatController>().args['profilePicUrl'],
                                    headerText: 'Image',
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GradientText(
                                          Get.find<AdminChatController>().args['userName'],
                                          textAlign: TextAlign.center,
                                          colors: [royal, redOrenge],
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                letterSpacing: 2,
                                                fontSize: 20,
                                                height: 1,
                                              ),
                                        ),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        Text(
                                          Get.find<AdminChatController>().args['phoneNumber'],
                                          style: TextStyle(
                                            color: royal,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Get.find<AdminChatController>().args['isAdmin']
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 1,
                                                ),
                                                decoration: BoxDecoration(color: slate.withOpacity(0.4), borderRadius: BorderRadius.circular(5)),
                                                child: GradientText(
                                                  "ADMIN",
                                                  colors: [
                                                    royal,
                                                    redOrenge,
                                                  ],
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                              )
                                            : Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 1,
                                                    ),
                                                    decoration: BoxDecoration(color: slate.withOpacity(0.4), borderRadius: BorderRadius.circular(5)),
                                                    child: GradientText(
                                                      Get.find<AdminChatController>().args['userType'],
                                                      colors: [
                                                        royal,
                                                        redOrenge,
                                                      ],
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  Get.find<AdminChatController>().args['isVarified']
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) => AlertDialog(
                                                                actionsPadding: EdgeInsets.only(bottom: 20),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                backgroundColor: concrete,
                                                                title: GradientText(
                                                                  "Un-verify User",
                                                                  colors: [redOrenge, royal, redOrenge],
                                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                        fontSize: 20,
                                                                        letterSpacing: 2,
                                                                      ),
                                                                ),
                                                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                                                actions: [
                                                                  ElevatedButton(
                                                                    onPressed: () => Get.back(),
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                            color: offWhite,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      primary: redOrenge,
                                                                    ),
                                                                    onPressed: () async {
                                                                      Get.back();
                                                                      await Get.find<DbController>().varificationChange(
                                                                        docId: Get.find<AdminChatController>().docId,
                                                                        value: false,
                                                                      );
                                                                      Get.back();
                                                                    },
                                                                    child: Text(
                                                                      "Confirm",
                                                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                            color: offWhite,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          child: CircleAvatar(
                                                            radius: 15,
                                                            child: Icon(
                                                              Icons.done_all_rounded,
                                                              color: Colors.greenAccent,
                                                            ),
                                                            backgroundColor: slate.withOpacity(1),
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) => AlertDialog(
                                                                actionsPadding: EdgeInsets.only(bottom: 20),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                backgroundColor: concrete,
                                                                title: GradientText(
                                                                  "Verify User",
                                                                  colors: [redOrenge, royal, redOrenge],
                                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                        fontSize: 20,
                                                                        letterSpacing: 2,
                                                                      ),
                                                                ),
                                                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                                                actions: [
                                                                  ElevatedButton(
                                                                    onPressed: () => Get.back(),
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                            color: offWhite,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      primary: redOrenge,
                                                                    ),
                                                                    onPressed: () async {
                                                                      Get.back();
                                                                      await Get.find<DbController>().varificationChange(
                                                                        docId: Get.find<AdminChatController>().docId,
                                                                        value: true,
                                                                      );
                                                                      Get.back();
                                                                    },
                                                                    child: Text(
                                                                      "Confirm",
                                                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                            color: offWhite,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          child: CircleAvatar(
                                                            radius: 15,
                                                            child: Icon(
                                                              Icons.done_all_rounded,
                                                              color: Colors.grey,
                                                            ),
                                                            backgroundColor: slate.withOpacity(1),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              // indent: 30,
                              // endIndent: 30,
                              height: 20,
                              color: royal.withOpacity(0.2),
                              thickness: 1,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: slate.withOpacity(0.2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomNetworkImageWidget(
                                    url: Get.find<AdminChatController>().args['logoUrl'],
                                    headerText: 'Logo',
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GradientText(
                                          Get.find<AdminChatController>().args['firmName'],
                                          textAlign: TextAlign.center,
                                          colors: [royal, redOrenge],
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                fontSize: 15,
                                                height: 1,
                                              ),
                                        ),
                                        Text(
                                          "GST NO : ${Get.find<AdminChatController>().args['gstNo']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: royal,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            height: 1,
                                          ),
                                        ),
                                        Divider(
                                          // indent: 30,
                                          // endIndent: 30,
                                          height: 10,
                                          color: royal.withOpacity(0.2),
                                          thickness: 1,
                                        ),
                                        Get.find<AdminChatController>().args['bankName'].isEmpty
                                            ? SizedBox.shrink()
                                            : Text(
                                                "BANK NAME : ${Get.find<AdminChatController>().args['bankName']}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: royal,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1,
                                                ),
                                              ),
                                        Get.find<AdminChatController>().args['accountNo'].isEmpty
                                            ? SizedBox.shrink()
                                            : Text(
                                                "A/C : ${Get.find<AdminChatController>().args['accountNo']}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: royal,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1,
                                                ),
                                              ),
                                        Get.find<AdminChatController>().args['ifscCode'].isEmpty
                                            ? SizedBox.shrink()
                                            : Text(
                                                "IFSC CODE : ${Get.find<AdminChatController>().args['ifscCode']}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: royal,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(Get.find<AdminChatController>().args['profilePicUrl']),
            ),
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(20),
          //   child: Image.network(
          //     Get.find<AdminChatController>().args['profilePicUrl'],
          //     width: 40,
          //     height: 40,
          //   ),
          // ),
          SizedBox(
            width: 10,
          ),
        ],
        title: TitleWidget(
          title: Get.find<AdminChatController>().args['userName'],
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 1,
              child: CircleAvatar(
                backgroundColor: royal,
                child: Icon(
                  Icons.arrow_back,
                  color: slate,
                ),
              ),
            ),
            onPressed: () => Get.back(),
          ),
        ),
        elevation: 1,
        backgroundColor: slate,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [slate, concrete],
              begin: Alignment(0, -1),
              end: Alignment(0, 0),
            ),
          ),
          child: PageView(
            onPageChanged: (value) {
              if (value == 0) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            controller: PageController(initialPage: 1),
            physics: BouncingScrollPhysics(),
            children: [
              AdminAssignProductView(),
              ChatPage(),
            ],
          ),
        ),
      ),
    );
  }
}
