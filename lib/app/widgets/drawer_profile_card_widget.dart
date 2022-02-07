import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'custom_network_image_widget.dart';

class DrawerProfileCard extends StatelessWidget {
  final void Function()? onPress;

  const DrawerProfileCard({
    Key? key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
        color: concrete,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
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
                  url: Get.find<DbController>().userProfile.value.profilePicUrl,
                  headerText: 'Image',
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      GradientText(
                        Get.find<DbController>().userProfile.value.userName,
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
                        Get.find<DbController>().userProfile.value.phoneNumber,
                        style: TextStyle(
                          color: royal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Get.find<DbController>().userProfile.value.isAdmin
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                  color: slate.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5)),
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
                                  decoration: BoxDecoration(
                                      color: slate.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: GradientText(
                                    Get.find<DbController>()
                                        .userProfile
                                        .value
                                        .userType,
                                    colors: [
                                      royal,
                                      redOrenge,
                                    ],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Get.find<DbController>()
                                        .userProfile
                                        .value
                                        .isVarified
                                    ? CircleAvatar(
                                        radius: 15,
                                        child: Icon(
                                          Icons.done_all_rounded,
                                          color: Colors.greenAccent,
                                        ),
                                        backgroundColor: slate.withOpacity(1),
                                      )
                                    : SizedBox.shrink(),
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
                  url: Get.find<DbController>().userProfile.value.logoUrl,
                  headerText: 'Logo',
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      GradientText(
                        Get.find<DbController>().userProfile.value.firmName,
                        textAlign: TextAlign.center,
                        colors: [royal, redOrenge],
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 15,
                              height: 1,
                            ),
                      ),
                      Text(
                        "GST NO : ${Get.find<DbController>().userProfile.value.gstNo}",
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
                      Get.find<DbController>()
                              .userProfile
                              .value
                              .bankName
                              .isEmpty
                          ? SizedBox.shrink()
                          : Text(
                              "BANK NAME : ${Get.find<DbController>().userProfile.value.bankName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: royal,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                      Get.find<DbController>()
                              .userProfile
                              .value
                              .accountNo
                              .isEmpty
                          ? SizedBox.shrink()
                          : Text(
                              "A/C : ${Get.find<DbController>().userProfile.value.accountNo}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: royal,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                      Get.find<DbController>()
                              .userProfile
                              .value
                              .ifscCode
                              .isEmpty
                          ? SizedBox.shrink()
                          : Text(
                              "IFSC CODE : ${Get.find<DbController>().userProfile.value.ifscCode}",
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
    );
  }
}
