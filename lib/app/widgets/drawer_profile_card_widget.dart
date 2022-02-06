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
      padding: EdgeInsets.all(20),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomNetworkImageWidget(
            url: Get.find<DbController>().userProfile.value.profilePicUrl,
          ),
           CustomNetworkImageWidget(
            url: Get.find<DbController>().userProfile.value.logoUrl,
          ),
        ],
      ),
    );
  }
}
