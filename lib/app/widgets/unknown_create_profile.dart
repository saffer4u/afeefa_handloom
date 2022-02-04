import 'package:afeefa_handloom/app/modules/home/create_edit_profile/controllers/create_edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../constents/colors.dart';

class UnknownCreateProfile extends StatelessWidget {
  const UnknownCreateProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.grey,
            offset: Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            concrete,
            offWhite,
          ],
          begin: Alignment(0, -1),
          end: Alignment(0, 0),
        ),
      ),
      child: Center(
        child: GradientText(
          "${Get.find<CreateEditProfileController>().userTypeDropDownValue.value} Management\n Not implimented yet",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 20,
              ),
          colors: [royal, redOrenge],
        ),
      ),
    );
  }
}
